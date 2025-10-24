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
        label.font = UIFont(name: "Marker Felt", size: 36) ?? .boldSystemFont(ofSize: 36)
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type your name.."
        textField.textAlignment = .center
        textField.font = UIFont(name: "Marker Felt", size: 24) ?? .systemFont(ofSize: 24)
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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
        
    private func setupView() {
        layer.cornerRadius = 40
        layer.masksToBounds = true
        
        configureGradient(colors: [
            UIColor(red: 0.3, green: 0.4, blue: 1.0, alpha: 1.0),
            UIColor(red: 0.1, green: 0.2, blue: 0.8, alpha: 1.0)
        ])
        
        addSubview(titleLabel)
        addSubview(textField)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
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

