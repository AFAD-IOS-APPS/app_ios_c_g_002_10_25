//
//  NameInputView.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 20/10/2025.
//

import UIKit
import Combine

final class NameInputView: GradientView {
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "WHAT IS YOUR NAME?"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = .chalkboard(size: 28)
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type your name.."
        textField.textAlignment = .center
        textField.font = .chalkboard(size: 22)
        textField.textColor = .darkGray
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 30
        return textField
    }()
    
    var textPublisher: AnyPublisher<String, Never> {
        textField.textPublisher
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupView() {
        layer.cornerRadius = 40
        layer.masksToBounds = true
        
        configureGradient(colors: [
            .blueGradientFirst,
            .blueGradientSecond
        ])
        
        [
            titleLabel,
            textField
        ].forEach(addView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 38),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 36),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            textField.heightAnchor.constraint(equalToConstant: 60),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ])
    }
}

