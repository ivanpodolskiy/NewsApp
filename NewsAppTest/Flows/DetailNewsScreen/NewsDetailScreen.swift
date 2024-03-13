//
//  NewsDetailScreen.swift
//  NewsAppTest
//
//  Created by user on 01.03.2024.
//

import UIKit
import Combine

class NewsDetailScreen: UIViewController {
    
    private struct Constants {
        static let imageHeight: CGFloat = 210
        static let spacing: CGFloat = 13
    }
    
    private var viewModel: DetailViewModel
    private var topAnchor: NSLayoutConstraint!
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubiews()
        activattopBackgroundLayout()
        activateLayoutConstraint()
        setData()
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .notSelected
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let topBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .primaryBlue
        return view
    }()
    
    private let categoryView: CategoryLabel = {
        let label = CategoryLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "Georgia", size: 27)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private func setData(){
        let item = viewModel.newsItem
        categoryView.setTitle(item.category.rawValue)
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        
        viewModel.$newsImage
            .sink { [weak self] image in
                guard let self = self, let image = image else { return }
                self.setImageWithAnimation(image)
            }
            .store(in: &cancellables)
        
        if viewModel.hasImage {
            view.addSubview(imageView)
            activateImageLayout()
            viewModel.loadImage()
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private func setImageWithAnimation(_ image: UIImage) {
        DispatchQueue.main.async {
            UIView.transition(with: self.imageView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.imageView.image = image
            })
        }
    }
    
    private func setupSubiews() {
        view.addSubview(topBackgroundView)
        view.addSubview(categoryView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
    }
    
    //MARK: - LayoutConstraint
    private  func activattopBackgroundLayout() {
        topBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    private func activateLayoutConstraint() {
        topAnchor = categoryView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor, constant: Constants.spacing)
        topAnchor.isActive = true
        categoryView.heightAnchor.constraint(equalToConstant: 29).isActive = true
        categoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing).isActive = true
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: Constants.spacing),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.spacing),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.spacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.spacing),
        ])
    }
    
    private func activateImageLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
        ])
        updateUpperAnchor()
    }
    private func updateUpperAnchor() {
        topAnchor.isActive = false
        categoryView.topAnchor.constraint(equalTo:  imageView.bottomAnchor, constant: Constants.spacing).isActive = true
    }
}
