//
//  AccountInfoView.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import UIKit
import Combine

final class AccountInfoView: GradientView {
    
    private let nameTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.text = UserDefaultsManager.shared.name
        textField.placeholder = "Your name:"
        textField.font = .chalkboard(size: 22, weight: .regular)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 23
        textField.textPadding = .init(top: 4, left: 18, bottom: 4, right: 32)
        
        let imageView = UIImageView(image: .edit)
        imageView.contentMode = .scaleAspectFit

        let container = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.frame = CGRect(x: -10, y: 0, width: 20, height: 20)
        container.addSubview(imageView)
        textField.rightView = container
        textField.rightViewMode = .always
        
        return textField
    }()
    
    private let ageTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.text = UserDefaultsManager.shared.age
        textField.placeholder = "Your age:"
        textField.font = .chalkboard(size: 22, weight: .regular)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 23
        textField.textPadding = .init(top: 4, left: 18, bottom: 4, right: 36)
        
        let imageView = UIImageView(image: .edit)
        imageView.contentMode = .scaleAspectFit

        let container = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.frame = CGRect(x: -10, y: 0, width: 20, height: 20)
        container.addSubview(imageView)
        textField.rightView = container
        textField.rightViewMode = .always
        
        return textField
    }()
    
    var namePublisher: AnyPublisher<String, Never> {
        nameTextField.textPublisher
    }
    
    var agePublisher: AnyPublisher<String, Never> {
        ageTextField.textPublisher
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
        
        nameTextField.text = UserDefaultsManager.shared.name
        ageTextField.text = UserDefaultsManager.shared.age
        
        configureGradient(
            colors: [
                .blueGradientFirst,
                .blueGradientSecond
            ]
        )
        
        [
            nameTextField,
            ageTextField
        ].forEach(addView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 63),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 55),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -55),
            nameTextField.heightAnchor.constraint(equalToConstant: 46),
            
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 14),
            ageTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 55),
            ageTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -55),
            ageTextField.heightAnchor.constraint(equalToConstant: 46),
            ageTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -63)
        ])
    }
}


