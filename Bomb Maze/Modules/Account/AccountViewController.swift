//
//  AccountViewController.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import UIKit
import Combine

protocol AccountViewProtocol: AnyObject {}

class AccountViewController: UIViewController, AccountViewProtocol {
    
    private let presenter: AccountPresenter
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        return stackView
    }()
    
    private let accountView = UIView()
    
    private let accountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = .account
        return imageView
    }()
    
    private let accountInfoView = AccountInfoView()
    
    private let cancelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = .cross
        return imageView
    }()
    
    private let acceptImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = .check
        return imageView
    }()
    
    private let buttonsContainerView = UIView()
    private let buttonsView = UIView()
    
    var cancellables = Set<AnyCancellable>()
        
    init(presenter: AccountPresenter) {
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
        
        accountInfoView.namePublisher
            .sink { [weak self] text in
                self?.presenter.updateName(with: text)
            }
            .store(in: &cancellables)
        
        accountInfoView.agePublisher
            .sink { [weak self] text in
                self?.presenter.updateAge(with: text)
            }
            .store(in: &cancellables)
    }

    private func setupViews() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        accountView.addView(accountImageView)
        buttonsContainerView.addView(buttonsView)
        [cancelImageView, acceptImageView].forEach(buttonsView.addView)
        [accountView, accountInfoView, buttonsContainerView].forEach(containerStackView.addArrangedSubview)
        view.addView(containerStackView)
        
        configureIcons()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
            containerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            accountView.heightAnchor.constraint(equalToConstant: 105),
            
            accountImageView.centerXAnchor.constraint(equalTo: accountView.centerXAnchor),
            accountImageView.heightAnchor.constraint(equalToConstant: 105),
            accountImageView.widthAnchor.constraint(equalToConstant: 105),
            
            buttonsContainerView.heightAnchor.constraint(equalToConstant: 68),
            
            buttonsView.topAnchor.constraint(equalTo: buttonsContainerView.topAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: buttonsContainerView.bottomAnchor),
            buttonsView.centerXAnchor.constraint(equalTo: buttonsContainerView.centerXAnchor),
            
            cancelImageView.heightAnchor.constraint(equalToConstant: 68),
            cancelImageView.topAnchor.constraint(equalTo: buttonsView.topAnchor),
            cancelImageView.bottomAnchor.constraint(equalTo: buttonsView.bottomAnchor),
            cancelImageView.leadingAnchor.constraint(equalTo: buttonsView.leadingAnchor),
            
            acceptImageView.heightAnchor.constraint(equalToConstant: 68),
            acceptImageView.leadingAnchor.constraint(equalTo: cancelImageView.trailingAnchor, constant: 54),
            acceptImageView.topAnchor.constraint(equalTo: buttonsView.topAnchor),
            acceptImageView.bottomAnchor.constraint(equalTo: buttonsView.bottomAnchor),
            acceptImageView.trailingAnchor.constraint(equalTo: buttonsView.trailingAnchor)
        ])
    }
    
    private func configureIcons() {
        let cancelRecognizer = UITapGestureRecognizer(target: self, action: #selector(cancelChanges))
        cancelImageView.addGestureRecognizer(cancelRecognizer)
        
        let acceptRecognizer = UITapGestureRecognizer(target: self, action: #selector(acceptChanges))
        acceptImageView.addGestureRecognizer(acceptRecognizer)
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
    
    @objc private func cancelChanges() {
        presenter.coordinator.dismiss()
    }
    
    @objc private func acceptChanges() {
        presenter.acceptChanges()
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        adjustForKeyboard(notification: notification, viewToMove: view)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        adjustForKeyboard(notification: notification, viewToMove: view)
    }
}
