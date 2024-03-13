//
//  CategoryCell.swift
//  NewsAppTest
//
//  Created by user on 01.03.2024.
//

import UIKit


class CategoryCell: UICollectionViewCell {
    private lazy var categorButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isSelected = false
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        button.addTarget(self, action: #selector(buttonStateChanged), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .none
        setButtonConfig()
        addSubview(categorButton)
        activateLayoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setButtonConfig() {
        categorButton.configurationUpdateHandler = { button in
            if button.isSelected {
                button.configuration?.baseForegroundColor  =  .white
                button.configuration?.background.backgroundColor = .primaryBlue
            } else  {
                button.configuration?.background.backgroundColor = .notSelected
                button.configuration?.baseForegroundColor = .black
            }
        }
        categorButton.setNeedsUpdateConfiguration()
    }
    
    private func activateLayoutConstraint() {
        NSLayoutConstraint.activate([
            categorButton.topAnchor.constraint(equalTo: topAnchor),
            categorButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            categorButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            categorButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setTitle(_ title : String) {
        categorButton.setTitle(title, for: .normal)
    }
    
    @objc private func buttonStateChanged(_ button: UIButton) {
        button.isSelected.toggle()
    }
}

extension CategoryCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
