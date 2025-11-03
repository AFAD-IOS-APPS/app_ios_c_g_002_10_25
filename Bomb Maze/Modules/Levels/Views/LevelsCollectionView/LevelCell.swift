//
//  LevelCell.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import UIKit

final class LevelCell: UICollectionViewCell {
    static let identifier = "LevelCell"
    
    private let roundView: GradientView = {
        let view = GradientView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 55 / 2
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.textAlignment = .center
        return label
    }()
    
    private let lockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .lock
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 17
        contentView.layer.masksToBounds = true
        
        contentView.addView(roundView)
        [
            numberLabel,
            lockImageView
        ].forEach(roundView.addView)
        
        NSLayoutConstraint.activate([
            roundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            roundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            roundView.widthAnchor.constraint(equalToConstant: 55),
            roundView.heightAnchor.constraint(equalToConstant: 55),
            
            numberLabel.centerXAnchor.constraint(equalTo: roundView.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: roundView.centerYAnchor),
            
            lockImageView.widthAnchor.constraint(equalToConstant: 27),
            lockImageView.heightAnchor.constraint(equalToConstant: 36),
            lockImageView.centerXAnchor.constraint(equalTo: roundView.centerXAnchor),
            lockImageView.centerYAnchor.constraint(equalTo: roundView.centerYAnchor),
        ])
    }
    
    func configure(with index: Int) {
        numberLabel.isHidden = false
        lockImageView.isHidden = true
        roundView.configureGradient(
            colors: [
                .magentaGradientFirst,
                .magentaGradientSecond
            ]
        )
        
        numberLabel.text = "\(index + 1)"
    }
    
    func configureEmpty() {
        numberLabel.isHidden = true
        lockImageView.isHidden = false
        roundView.configureGradient(
            colors: [
                .gray,
                .gray
            ]
        )
    }
}


