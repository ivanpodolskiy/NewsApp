//
//  ViewController.swift
//  NewsAppTest
//
//  Created by user on 29.02.2024.
//

import UIKit

class MainViewController: UIViewController {
    private var mainViewModel = NewsViewModel()
    private struct Constants {
        static let categoryTopConstant: CGFloat = 25
        static let categoryHeight: CGFloat = 33
    }
    
    private var fetchNewsService = NewsDataService()
    
    private var categoryTopConstraint: NSLayoutConstraint!
    private var items: [NewsItem] = []
    
    private let topBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .primaryBlue
        return view
    }()
    
    private lazy var categoryCollection: UICollectionView = {
        let categoryCollection = CategoryCollection(frame: .zero, collectionViewLayout:  UICollectionViewFlowLayout())
        categoryCollection.translatesAutoresizingMaskIntoConstraints = false
        return categoryCollection
    }()
    
    private lazy var newsBannerCollection: UICollectionView = {
        let bannerCollection = NewsBannerCollection(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        bannerCollection.translatesAutoresizingMaskIntoConstraints = false
        bannerCollection.dataSource = self
        bannerCollection.delegate = self
        
        bannerCollection.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        bannerCollection.register(BannerWithImageCell.self, forCellWithReuseIdentifier: BannerWithImageCell.identifier)
        return bannerCollection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviews()
        activateLayoutConstraint()
        fetchNews()
    }
    
    private func fetchNews() {
        fetchNewsService.fecthNews(completion: { [weak self] result in
            guard let self = self else { return  }
            switch result {
            case .success(let items): loadData(items)
            case .failure(let error): print (error)
            }
        })
    }
    
    private func loadData(_ data: [NewsItem]) {
        items = data
        DispatchQueue.main.async {
            self.newsBannerCollection.reloadData()
        }
    }
    
    private func setSubviews() {
        view.addSubview(categoryCollection)
        view.addSubview(topBackgroundView)
        view.addSubview(newsBannerCollection)
    }
    
    private func activateLayoutConstraint() {
        categoryTopConstraint = categoryCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.categoryTopConstant)
        
        NSLayoutConstraint.activate([
            topBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            topBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            categoryTopConstraint,
            categoryCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryCollection.heightAnchor.constraint(equalToConstant: Constants.categoryHeight),
            
            newsBannerCollection.topAnchor.constraint(equalTo: categoryCollection.bottomAnchor),
            newsBannerCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newsBannerCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            newsBannerCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard items.count > indexPath.row else { return }
        let item = items[indexPath.row]
        let deatailVC = NewsDetailScreen(newsItem: item)
        navigationController?.pushViewController(deatailVC, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        changeConstraintWithAnimation(offsetY: scrollView.contentOffset.y, animationDuration: 0.2)
    }
    
    private func changeConstraintWithAnimation(offsetY: CGFloat, animationDuration: TimeInterval) {
        let zeroOffest: CGFloat = 0
        guard  categoryTopConstraint.constant != -Constants.categoryHeight || offsetY <= zeroOffest else { return }
        categoryTopConstraint.constant = max(-Constants.categoryHeight, min(Constants.categoryTopConstant, categoryTopConstraint.constant - offsetY))
        
        UIView.animate(withDuration: animationDuration) { self.view.layoutIfNeeded() }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < items.count {
            let item  = items[indexPath.row]
            let cell = getPickedCell(item: item, for: collectionView, indexPath: indexPath)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    private func getPickedCell(item: NewsItem, for collectionView: UICollectionView, indexPath: IndexPath) ->  UICollectionViewCell{
        var  cell: BannerCell
        if item.imageURL != nil { cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerWithImageCell.identifier, for: indexPath) as! BannerWithImageCell }
        else { cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as! BannerCell }
        cell.configure(with: item)
        return cell
    }
}
