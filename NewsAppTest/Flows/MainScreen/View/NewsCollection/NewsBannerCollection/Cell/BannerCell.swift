//
//  Cell.swift
//  NewsAppTest
//
//  Created by user on 29.02.2024.
//

import UIKit

class BannerCell: UICollectionViewCell {
    internal var viewModel: NewsCellViewModel?
    var spacing: CGFloat = 13
    
    func configure(with viewModel: NewsCellViewModel) {
        self.viewModel = viewModel
        setData()
   }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setSubviews()
        self.activateSubviewsLayout()
        self.activateContainerLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setData() {
        let title = viewModel?.getTitle()
        let category = viewModel?.getTypeCategory().rawValue
        
        self.titleLabel.text = title
        self.categoryLabel.text = category
    }
  
  
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
        titleLabel.text = ""
        categoryLabel.text = ""
    }
    
    internal let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width:0  , height: 0)
        view.layer.shadowColor = UIColor.black.cgColor
        return view
    }()
    
    internal let  titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    internal let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 158 / 255, green: 158 / 255, blue: 158 / 255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 17 , weight: .medium)
        return label
    }()
    
    internal func setSubviews() {
        addSubview(containerView)
        containerView.addSubview(categoryLabel)
        containerView.addSubview(titleLabel)
    }
    
    internal func activateSubviewsLayout() {
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo:  containerView.topAnchor , constant: spacing),
            categoryLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: spacing),
            categoryLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -spacing),
            categoryLabel.heightAnchor.constraint(equalToConstant: 29),
            
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: spacing),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -spacing),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -spacing),
        ])
    }
    
    internal func activateContainerLayout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension BannerCell: ReusableView {
    static var identifier: String {
        String(describing: self)
    }
}
