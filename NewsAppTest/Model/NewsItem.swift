//
//  NewsS.swift
//  NewsAppTest
//
//  Created by user on 01.03.2024.
//

import Foundation
enum CategoryTypeNews: String {
    case all
    case car
    case company
}

protocol NewsSP {
    var title: String {get}
    var imageURL: String? {get}
    var category: CategoryTypeNews {get}
    var description: String { get}
}

    struct NewsItem : NewsSP {
        var title: String
        
        var imageURL: String?
        
        var category: CategoryTypeNews
        
        var description: String
        
        init(from newsData: News) {
            self.title = newsData.title
            self.category = .all
            self.description = newsData.description
            self.imageURL = newsData.titleImageURL
        }
    
}
