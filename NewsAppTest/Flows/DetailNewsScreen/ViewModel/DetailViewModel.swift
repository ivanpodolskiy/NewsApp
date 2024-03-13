//
//  DetailViewModel.swift
//  NewsAppTest
//
//  Created by user on 12.03.2024.
//

import UIKit
import Combine

class DetailViewModel: ViewModel {
    private var cancellables: [AnyCancellable] = []
    private let imageLoader: CacheImageLoaderProtocl

    var newsItem: NewsItem
    @Published var newsImage: UIImage!
    
    var hasImage: Bool {
        newsItem.imageURL != nil
    }
    
    init(_ newsItem:  NewsItem, imageLoader: CacheImageLoaderProtocl) {
        self.newsItem = newsItem
        self.imageLoader = imageLoader
    }
    
    func loadImage() {
        guard let stringImage = newsItem.imageURL,  let url = URL(string: stringImage) else { return }
        cancellables.removeAll()
        let cancellable = imageLoader.loadImage(from: url)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    print("Ошибка загрузки изображения: \(error)")
                    self.newsImage = UIImage(named: "placeholder")!
                case .finished:
                    break
                }
            } receiveValue: { [weak self]  image in
                guard let self = self, let image = image else { return }
                self.newsImage = image
            }
        cancellables.append(cancellable)
    }
}
