//
//  Coordinator.swift
//  NewsAppTest
//
//  Created by user on 12.03.2024.
//

import UIKit
import Combine

protocol Coordinator {
    func launch()
    func pushDetailVC(with item: NewsItem)
    var navigationController: UINavigationController {get}
}

class NewsCoordinator: Coordinator {
    private let service = NewsDataService()
    private let imageLoader = CacheImageLoader()
    
    internal var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
        setupNavigation()
    }
    func launch() {
        let viewModel = NewsViewModel(service: service, coordinator: self, imageLoader: imageLoader)
        
        let mainViewController = MainViewController(viewModel: viewModel)
        mainViewController.title = "Новости"
        mainViewController.view.backgroundColor = .white
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
    func pushDetailVC(with item: NewsItem) {
        let viewModel = DetailViewModel(item, imageLoader: imageLoader)
        let detailViewController = NewsDetailScreen(viewModel: viewModel)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    private func setupNavigation() {
        navigationController.navigationBar.backgroundColor = UIColor(named: "PrimaryBlue")
        navigationController.navigationBar.tintColor = .white
        
        let fontAttributes: [NSAttributedString.Key: Any] = [
            .font : UIFont(name: "Georgia", size: 20)!,
            .foregroundColor : UIColor.white
        ]
        
        navigationController.navigationBar.titleTextAttributes = fontAttributes
    }
}
