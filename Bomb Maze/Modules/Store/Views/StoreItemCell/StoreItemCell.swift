//
//  StoreItemCell.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 29/10/2025.
//

import UIKit

final class StoreItemCell: UICollectionViewCell {
    static let reuseId = "StoreItemCell"
    
    private let itemImageView = UIImageView()
    
    private let priceContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .sfPro(size: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        priceContainerView.addView(priceLabel)
        [itemImageView, priceContainerView].forEach(contentView.addView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor),
            
            priceContainerView.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 5),
            priceContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            priceContainerView.heightAnchor.constraint(equalToConstant: 32),
            priceContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            priceLabel.centerXAnchor.constraint(equalTo: priceContainerView.centerXAnchor),
            priceLabel.centerYAnchor.constraint(equalTo: priceContainerView.centerYAnchor)
        ])
    }
    
    func configure(with model: StoreItemCellModel) {
        itemImageView.image = model.image
        priceContainerView.backgroundColor = model.backgroundColor
        
        if model.showCurrency {
            configureTextAttachment(with: model.priceText)
        } else {
            priceLabel.text = model.priceText
        }
    }
    
    private func configureTextAttachment(with priceText: String) {
        let attachment = NSTextAttachment()
        attachment.image = UIImage.currency.withTintColor(.white)
        attachment.bounds = CGRect(x: 0, y: -3, width: 20, height: 20)
        
        let attachmentString = NSAttributedString(attachment: attachment)
        let priceString = NSAttributedString(string: "  \(priceText)", attributes: [
            .font: UIFont.sfPro(size: 16),
            .foregroundColor: UIColor.white
        ])
        
        let combined = NSMutableAttributedString()
        combined.append(attachmentString)
        combined.append(priceString)
        
        priceLabel.attributedText = combined
    }
}
