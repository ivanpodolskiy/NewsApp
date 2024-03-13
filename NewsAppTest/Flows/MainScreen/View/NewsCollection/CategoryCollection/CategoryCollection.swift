//
//  CategoryHeader.swift
//  NewsAppTest
//
//  Created by user on 01.03.2024.
//

import UIKit

class CategoryCollection: UICollectionView  {
    private let adapter = Adapter()

    private let spacing: CGFloat = 25
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        setCollectionViewLayout(getCollectionViewLayout(), animated: true)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        backgroundColor = .white
        dataSource = adapter
        isScrollEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension:  .estimated(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(13)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 0)

        section.supplementaryContentInsetsReference = .automatic
        section.orthogonalScrollingBehavior = .paging
        section.contentInsetsReference = .automatic
        

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

class Adapter: NSObject, UICollectionViewDataSource {
    private let categoryArray = ["Автомобили", "Компания"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        cell.setTitle(categoryArray[indexPath.row])
        return cell
    }
}
