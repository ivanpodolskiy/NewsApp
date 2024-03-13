//
//  CategoryView.swift
//  NewsAppTest
//
//  Created by user on 03.03.2024.
//

import UIKit

class CategoryLabel: UIView {
    func setTitle(_ text: String) {
        categoryTitle.text = text
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .notSelected
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let categoryTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        activateLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    private func setupSubviews(){
        addSubview(containerView)
        containerView.addSubview(categoryTitle)
    }
    private func activateLayout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            categoryTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            categoryTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            categoryTitle.topAnchor.constraint(equalTo: containerView.topAnchor),
            categoryTitle.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}



