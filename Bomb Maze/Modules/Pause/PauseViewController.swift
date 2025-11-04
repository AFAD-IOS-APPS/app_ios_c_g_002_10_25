//
//  PauseViewController.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 25/10/2025.
//

import UIKit
import Combine

protocol PauseViewProtocol: AnyObject {}

class PauseViewController: UIViewController, PauseViewProtocol {
    
    private let presenter: PausePresenter
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let resumeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = .resume
        return imageView
    }()
    
    private let musicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let exitView = UIView()
    
    private let exitImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = .exit
        return imageView
    }()
    
    private let pauseLabel: UILabel = {
        let label = UILabel()
        label.text = "PAUSE"
        label.font = .chalkboard(size: 48)
        label.textColor = .white
        return label
    }()
        
    init(presenter: PausePresenter) {
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
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            
        exitView.addView(exitImageView)
        [
            resumeImageView,
            musicImageView,
            exitView
        ].forEach(containerStackView.addArrangedSubview)
        
        [
            containerStackView,
            pauseLabel
        ].forEach(view.addView)
        configureIcons()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            
            resumeImageView.widthAnchor.constraint(equalToConstant: 60),
            resumeImageView.heightAnchor.constraint(equalToConstant: 60),
            
            musicImageView.widthAnchor.constraint(equalToConstant: 60),
            musicImageView.heightAnchor.constraint(equalToConstant: 60),
            
            exitView.heightAnchor.constraint(equalToConstant: 46),
            
            exitImageView.widthAnchor.constraint(equalToConstant: 46),
            exitImageView.heightAnchor.constraint(equalToConstant: 46),
            exitImageView.centerXAnchor.constraint(equalTo: exitView.centerXAnchor),
            exitImageView.centerYAnchor.constraint(equalTo: exitView.centerYAnchor),
            
            pauseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pauseLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureIcons() {
        let resumeRecognizer = UITapGestureRecognizer(target: self, action: #selector(resumeGame))
        resumeImageView.addGestureRecognizer(resumeRecognizer)
        
        let musicRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleMusic))
        musicImageView.addGestureRecognizer(musicRecognizer)
        musicImageView.image = presenter.isMusicEnabled ? .pausemusicOn : .pausemusicOff
        
        let exitRecognizer = UITapGestureRecognizer(target: self, action: #selector(exitGame))
        exitImageView.addGestureRecognizer(exitRecognizer)
        
        let backgroundRecognizer = UITapGestureRecognizer(target: self, action: #selector(resumeGame))
        view.addGestureRecognizer(backgroundRecognizer)
    }
    
    @objc private func resumeGame() {
        presenter.resumeGame()
    }
    
    @objc private func toggleMusic() {
        presenter.toggleMusic()
        musicImageView.image = presenter.isMusicEnabled ? .pausemusicOn : .pausemusicOff
    }
    
    @objc private func exitGame() {
        presenter.quitGame()
    }
}

