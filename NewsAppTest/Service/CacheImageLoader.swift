//
//  ImageLoader.swift
//  NewsAppTest
//
//  Created by user on 06.03.2024.
//
import Combine
import Foundation
import UIKit

public final class CacheImageLoader {
    private var cache: ImageCacheType
    private let backgroundQueue = DispatchQueue.global(qos: .background)
    static let shared = CacheImageLoader()
    
    init(cache: ImageCacheType = ImageCache()) {
        self.cache = cache
    }
    
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let imageCache = cache[url] { return Just(imageCache).eraseToAnyPublisher()  }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, _) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
        
            .subscribe(on: backgroundQueue)
            .handleEvents(receiveOutput: { [unowned self] image in
                guard let image = image else { return }
                self.cache[url] = image
            })
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
