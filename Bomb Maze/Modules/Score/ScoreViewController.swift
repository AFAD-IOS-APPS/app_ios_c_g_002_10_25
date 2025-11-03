//
//  ScoreViewController.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 27/10/2025.
//

import UIKit

protocol ScoreViewProtocol: AnyObject {}

class ScoreViewController: UIViewController, ScoreViewProtocol {
    
    private let presenter: ScorePresenter
    
    var playImage: UIImage {
        switch presenter.gameResult {
        case .win:
                .play
        case .lost:
                .replay
        }
    }
    
    private let scoreView = ScoreView()
    
    private let playImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let homeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = .home
        return imageView
    }()
        
    init(presenter: ScorePresenter) {
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
        scoreView.configure(
            model: presenter.getScoreModel()
        )
        playImageView.image = playImage
        
        let homeRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(showLevels)
        )
        homeImageView.addGestureRecognizer(homeRecognizer)
        
        let playRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didPressPlayButton)
        )
        playImageView.addGestureRecognizer(playRecognizer)

        [
            scoreView,
            playImageView,
            homeImageView
        ].forEach(view.addView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scoreView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            playImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            playImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playImageView.widthAnchor.constraint(equalToConstant: 110),
            playImageView.heightAnchor.constraint(equalToConstant: 110),
            
            homeImageView.trailingAnchor.constraint(equalTo: playImageView.leadingAnchor, constant: -18),
            homeImageView.centerYAnchor.constraint(equalTo: playImageView.centerYAnchor),
            homeImageView.widthAnchor.constraint(equalToConstant: 65),
            homeImageView.heightAnchor.constraint(equalToConstant: 65),
        ])
    }
    
    @objc private func showLevels() {
        presenter.coordinator.showLevels()
    }
    
    @objc private func didPressPlayButton() {
        presenter.handleGameFinish()
    }
}
