//
//  PageControl.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 31/10/2025.
//

import UIKit

final class PageControl: UIView {
    
    var numberOfPages: Int = 0 {
        didSet { setupDots() }
    }
    
    var currentPage: Int = 0 {
        didSet { updateDots() }
    }
    
    let activeImage = UIImage(resource: .pageControlActive)
    let inactiveImage = UIImage(resource: .pageControlInactive)
    var spacing: CGFloat = 10
    
    private var stackView = UIStackView()
    private var dotViews: [UIImageView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = spacing
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupDots() {
        dotViews.forEach { $0.removeFromSuperview() }
        dotViews = []
        
        for i in 0..<numberOfPages {
            let imageView = UIImageView()
            imageView.image = i == currentPage ? activeImage : inactiveImage
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
            stackView.addArrangedSubview(imageView)
            dotViews.append(imageView)
        }
    }
    
    private func updateDots() {
        for (index, dot) in dotViews.enumerated() {
            dot.image = index == currentPage ? activeImage : inactiveImage
        }
    }
}
