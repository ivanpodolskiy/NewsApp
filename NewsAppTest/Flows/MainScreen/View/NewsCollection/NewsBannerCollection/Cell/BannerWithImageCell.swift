//
//  BannerWithImageCell.swift
//  NewsAppTest
//
//  Created by user on 10.03.2024.
//

import UIKit
import Combine

class BannerWithImageCell: BannerCell {
    private var animator: UIViewPropertyAnimator?
    
    private(set) lazy var imageView: UIImageView  = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .notSelected
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func activateSubviewsLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200), // Размещаем изображение выше categoryLabel
            
            categoryLabel.topAnchor.constraint(equalTo:  imageView.bottomAnchor , constant: spacing),
            categoryLabel.heightAnchor.constraint(equalToConstant: 29),
            categoryLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: spacing),
            categoryLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -spacing),
            
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: spacing),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -spacing),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -spacing),
        ])
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override func setSubviews() {
        addSubview(containerView)
        containerView.addSubview(categoryLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(imageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        animator?.stopAnimation(true)
    }
    override func configure(with viewModel: NewsCellViewModel) {
        super.configure(with: viewModel)
        
        self.viewModel?.image.bind { [weak self] image in
            
            guard let self = self, let image = image else { return  }
            DispatchQueue.main.async {
                self.showImage(image)
            }
        }
        
        viewModel.loadImage()
    }
    private func showImage(_ image: UIImage?) {
        imageView.alpha = 0.0
        animator?.stopAnimation(false)
        
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.imageView.alpha = 1.0
        })
        imageView.image = image
    }
}

/*
 private var cancellable: AnyCancellable?

override func configure(with newsItem: NewsItem) {
    super.configure(with: newsItem)
    guard let imageURL = newsItem.imageURL else { return }
    cancellable =   loadImage(for: imageURL).sink { [unowned self] image in
        self.showImage(image)
    }
}

private func loadImage(for stringImage: String) -> AnyPublisher<UIImage?, Never> {
    return Just(stringImage)
        .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
            let url = URL(string: stringImage)!
            return CacheImageLoader.shared.loadImage(from: url)
        })
        .eraseToAnyPublisher()
}

private func showImage(_ image: UIImage?) {
    imageView.alpha = 0.0
    animator?.stopAnimation(false)
    imageView.image = image
    animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
        self.imageView.alpha = 1.0
    })
}
 */
