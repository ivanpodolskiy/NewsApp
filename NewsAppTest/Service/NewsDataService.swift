//
//  FetchNewsService.swift
//  NewsAppTest
//
//  Created by user on 01.03.2024.
//

import Foundation


protocol FetchNewsServicerotocol {
    func cancelPreviousRequests()
    func fecthNews(selectedCategories categoryValues: [CategoryTypeNews]?, completion: @escaping (Result<[NewsItem],NetworkError>) -> Void)
}

final class NewsDataService: FetchNewsServicerotocol {
    private let urlString: String
    private var networkService: NetworkingProtocol
    
    init() {
        self.networkService = NetworkService()
        self.urlString = "https://webapi.autodoc.ru/api/news/1/15"
    }
    
    func cancelPreviousRequests() {
        networkService.cancel()
    }
    
    func fecthNews(selectedCategories categoryValues: [CategoryTypeNews]?, completion: @escaping (Result<[NewsItem], NetworkError>) -> Void) {
        let url = URL(string: urlString)!
        networkService.sendRequest(from: url, decdoingType: NewsModel.self) {  result in
            switch result {
            case .success(let newsModel):
                var newsItems: [NewsItem] = []
                newsModel.newsItems.forEach { item in newsItems.append(NewsItem(from: item)) }
                completion(.success(newsItems))
                
            case .failure(let error) :
                print (error)
                
            }
        }
        
    }
}

