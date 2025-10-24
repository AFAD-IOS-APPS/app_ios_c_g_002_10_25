//
//  HomeViewController.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 21/10/2025.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    
}

final class HomeViewController: UIViewController, HomeViewProtocol {
    private let presenter: HomePresenter
    
    private let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = Assets.homeScreen.image
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let settingsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = Assets.settings.image
        return imageView
    }()
    
    private let accountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = Assets.account.image
        return imageView
    }()
    
    private let storeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = Assets.store.image
        return imageView
    }()
    
    private let levelsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = Assets.levels.image
        return imageView
    }()
    
    init(presenter: HomePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        [
            backgroundView,
            settingsImageView,
            accountImageView,
            storeImageView,
            levelsImageView
        ].forEach(view.addView)
        
        configureIcons()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            settingsImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            settingsImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            settingsImageView.widthAnchor.constraint(equalToConstant: 62),
            settingsImageView.heightAnchor.constraint(equalToConstant: 62),
            
            accountImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            accountImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            accountImageView.widthAnchor.constraint(equalToConstant: 62),
            accountImageView.heightAnchor.constraint(equalToConstant: 62),
            
            storeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            storeImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            storeImageView.widthAnchor.constraint(equalToConstant: 112),
            storeImageView.heightAnchor.constraint(equalToConstant: 112),
            
            levelsImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            levelsImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            levelsImageView.widthAnchor.constraint(equalToConstant: 178),
            levelsImageView.heightAnchor.constraint(equalToConstant: 178)
        ])
    }
    
    private func configureIcons() {
        let settingsRecognizer = UITapGestureRecognizer(target: self, action: #selector(openSettings))
        settingsImageView.addGestureRecognizer(settingsRecognizer)
        
        let accountRecognizer = UITapGestureRecognizer(target: self, action: #selector(openAccountInfo))
        accountImageView.addGestureRecognizer(accountRecognizer)
        
        let storeRecognizer = UITapGestureRecognizer(target: self, action: #selector(openStore))
        storeImageView.addGestureRecognizer(storeRecognizer)
        
        let levelsRecognizer = UITapGestureRecognizer(target: self, action: #selector(openLevels))
        levelsImageView.addGestureRecognizer(levelsRecognizer)
        
    }
    
    @objc private func openSettings() {
        
    }
    
    @objc private func openAccountInfo() {
        presenter.coordinator?.showAccountInfo()
    }
    
    @objc private func openStore() {
        
    }
    
    @objc private func openLevels() {
        presenter.coordinator?.showLevels()
    }
}
