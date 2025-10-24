//
//  IconBackgroundView.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 21/10/2025.
//

import UIKit

final class IconBackgroundView: GradientView {
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var iconWidthConstraint: NSLayoutConstraint!
    private var iconHeightConstraint: NSLayoutConstraint!
    private var tapAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        clipsToBounds = true
        
        addSubview(iconImageView)
        
        iconWidthConstraint = iconImageView.widthAnchor.constraint(equalToConstant: 40)
        iconHeightConstraint = iconImageView.heightAnchor.constraint(equalToConstant: 40)
        
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconWidthConstraint,
            iconHeightConstraint
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    func configure(with model: IconBackgroundViewModel) {
        configureGradient(colors: model.backgroundColors)
        layer.cornerRadius = model.cornerRadius
        iconImageView.image = model.icon
        iconWidthConstraint.constant = model.iconSize.width
        iconHeightConstraint.constant = model.iconSize.height
        tapAction = model.onTap
        
        layoutIfNeeded()
    }
    
    @objc private func handleTap() {
        tapAction?()
    }
}



