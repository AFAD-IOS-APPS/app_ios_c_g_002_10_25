//
//  GuideViewController.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 31/10/2025.
//

import UIKit

protocol GuideViewProtocol: AnyObject {}

final class GuideViewController: UIViewController, GuideViewProtocol {
    private let presenter: GuidePresenter
    
    private let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .guideScreen
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let howToPlayImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .howToPlay
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = .back
        return imageView
    }()
    
    private let startContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .greenGradientFirst
        view.layer.cornerRadius = 27
        view.layer.masksToBounds = true
        return view
    }()

    private let startLabel: UILabel = {
        let label = UILabel()
        label.text = "START"
        label.font = .chalkboard(size: 31)
        label.textColor = .white
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()
    
    init(presenter: GuidePresenter) {
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
        startContainerView.addView(startLabel)

        [
            backgroundView,
            howToPlayImageView,
            backImageView,
            startContainerView
            
        ].forEach(view.addView)
        
        configureIcons()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            backImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            backImageView.widthAnchor.constraint(equalToConstant: 62),
            backImageView.heightAnchor.constraint(equalToConstant: 62),
            
            howToPlayImageView.topAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: 15),
            howToPlayImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            howToPlayImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            startContainerView.topAnchor.constraint(equalTo: howToPlayImageView.bottomAnchor, constant: 15),
            startContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            startContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            startLabel.topAnchor.constraint(equalTo: startContainerView.topAnchor, constant: 6),
            startLabel.bottomAnchor.constraint(equalTo: startContainerView.bottomAnchor, constant: -6),
            startLabel.leadingAnchor.constraint(equalTo: startContainerView.leadingAnchor, constant: 25),
            startLabel.trailingAnchor.constraint(equalTo: startContainerView.trailingAnchor, constant: -25),
            
            startContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 54)
        ])
    }
    
    private func configureIcons() {
        let backRecognizer = UITapGestureRecognizer(target: self, action: #selector(back))
        backImageView.addGestureRecognizer(backRecognizer)
        
        let startRecognizer = UITapGestureRecognizer(target: self, action: #selector(back))
        startContainerView.addGestureRecognizer(startRecognizer)
    }
    
    @objc private func back() {
        presenter.coordinator.dismiss()
    }
}
