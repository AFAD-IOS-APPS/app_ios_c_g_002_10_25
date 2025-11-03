//
//  RegisterViewController.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 20/10/2025.
//

import UIKit
import Combine

protocol RegisterViewProtocol: AnyObject {}

class RegisterViewController: UIViewController, RegisterViewProtocol {
    
    private let presenter: RegisterPresenter
    
    private let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .launchScreen
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let dimmedLayer = CALayer()
    private let nameView = NameInputView()
    
    private let playImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = .play
        return imageView
    }()
    
    var cancellables = Set<AnyCancellable>()
    
    init(presenter: RegisterPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupKeyboardObservers()
        dismissKeyboardOnTap()
        
        nameView.textPublisher
            .sink { [weak self] text in
                self?.presenter.updateName(with: text)
            }
            .store(in: &cancellables)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dimmedLayer.frame = backgroundView.bounds
    }

    private func setupViews() {
        [
            backgroundView,
            nameView,
            playImageView
        ].forEach(view.addView)
        
        dimmedLayer.backgroundColor = UIColor.black.withAlphaComponent(0.7).cgColor
        backgroundView.layer.addSublayer(dimmedLayer)
        
        let tapRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(finishRegistration)
        )
        playImageView.addGestureRecognizer(tapRecognizer)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
            nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
            nameView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            playImageView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 57),
            playImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playImageView.widthAnchor.constraint(equalToConstant: 110),
            playImageView.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func finishRegistration() {
        presenter.finishRegistration()
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        adjustForKeyboard(notification: notification, viewToMove: view)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        adjustForKeyboard(notification: notification, viewToMove: view)
    }
}

