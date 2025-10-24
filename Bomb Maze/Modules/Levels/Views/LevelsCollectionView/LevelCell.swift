//
//  LevelCell.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import UIKit

final class LevelCell: UICollectionViewCell {
    static let identifier = "LevelCell"
    
    private let pinkCircleView: GradientView = {
        let view = GradientView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 55 / 2
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.textAlignment = .center
        return label
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
        
        pinkCircleView.configureGradient(
            colors: [
                Colors.magentaGradientFirstColor.color,
                Colors.magentaGradientSecondColor.color
            ]
        )
        
        contentView.addView(pinkCircleView)
        pinkCircleView.addView(numberLabel)
        
        NSLayoutConstraint.activate([
            pinkCircleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pinkCircleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pinkCircleView.widthAnchor.constraint(equalToConstant: 55),
            pinkCircleView.heightAnchor.constraint(equalToConstant: 55),
            
            numberLabel.centerXAnchor.constraint(equalTo: pinkCircleView.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: pinkCircleView.centerYAnchor)
        ])
    }
    
    func configure(
        with level: Level,
        at index: Int
    ) {
        numberLabel.text = "\(index + 1)"
    }
    
    func configureEmpty() {
        numberLabel.text = "0"
    }
}


