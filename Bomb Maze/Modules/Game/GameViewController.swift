//
//  GameViewController.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 23/10/2025.
//

import UIKit
import SpriteKit

protocol GameViewSceneDelegate: AnyObject {
    func didHitBall(points: Int)
    func didFinishGame()
}

protocol GameViewProtocol: AnyObject {
    func updateTimerLabel(with text: String)
    func updateScoreLabel(with text: String)
    func updateLevelLabel(with text: String)
    func setupScene(with level: Level)
    func resumeGame()
    func finishGame()
}

class GameViewController: UIViewController {
    private let presenter: GamePresenter

    private let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .gameScreen
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let pauseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = .pause
        return imageView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    private let timerCapsuleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .timerCapsule
        return imageView
    }()
    
    private let timerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    private let clockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .clock
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.font = .chalkboard(size: 37, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "YOUR SCORE:"
        label.font = .chalkboard(size: 31)
        label.textColor = .white
        return label
    }()
    
    private let scoreValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .chalkboard(size: 17, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let gameView: SKView = {
        let skView = SKView()
        skView.ignoresSiblingOrder = true
        skView.allowsTransparency = true
        skView.backgroundColor = .clear
        return skView
    }()
    
    private let levelContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .magentaGradientFirst
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()

    private let levelLabel: UILabel = {
        let label = UILabel()
        label.font = .sfPro(size: 28, weight: .black)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    init(presenter: GamePresenter) {
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
        setupGestureRecognizers()
        
        presenter.startGame()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let scene = gameView.scene, scene.size != gameView.bounds.size {
            scene.size = gameView.bounds.size
        }
    }
    
    private func setupViews() {
        [
            clockImageView,
            timerLabel
        ].forEach(timerStackView.addArrangedSubview)
        timerCapsuleImageView.addView(timerStackView)
        levelContainerView.addView(levelLabel)
        
        [
            timerCapsuleImageView,
            scoreLabel,
            scoreValueLabel,
            gameView
        ].forEach(mainStackView.addArrangedSubview)
        
        [
            backgroundView,
            mainStackView,
            pauseImageView,
            levelContainerView
        ].forEach(view.addView)
        

    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            timerCapsuleImageView.heightAnchor.constraint(equalToConstant: 60),
            
            timerStackView.centerYAnchor.constraint(equalTo: timerCapsuleImageView.centerYAnchor),
            timerStackView.leadingAnchor.constraint(equalTo: timerCapsuleImageView.leadingAnchor, constant: 25),
            timerStackView.trailingAnchor.constraint(equalTo: timerCapsuleImageView.trailingAnchor, constant: -25),
            
            pauseImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            pauseImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            pauseImageView.widthAnchor.constraint(equalToConstant: 60),
            pauseImageView.heightAnchor.constraint(equalToConstant: 60),
            
            clockImageView.widthAnchor.constraint(equalToConstant: 30),
            clockImageView.heightAnchor.constraint(equalToConstant: 30),
            
            gameView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            gameView.heightAnchor.constraint(equalTo: gameView.widthAnchor),
            
            levelContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            levelContainerView.centerYAnchor.constraint(equalTo: pauseImageView.centerYAnchor),
            levelContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            levelLabel.centerYAnchor.constraint(equalTo: levelContainerView.centerYAnchor),
            levelLabel.leadingAnchor.constraint(equalTo: levelContainerView.leadingAnchor, constant: 25),
            levelLabel.trailingAnchor.constraint(equalTo: levelContainerView.trailingAnchor, constant: -25),
            
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupGestureRecognizers() {
        let pauseRecognizer = UITapGestureRecognizer(target: self, action: #selector(pauseGame))
        pauseImageView.addGestureRecognizer(pauseRecognizer)
    }

    @objc private func pauseGame() {
        if let scene = gameView.scene as? GameScene {
            scene.pauseGame()
            presenter.pauseGame()
        }
    }
    
    override var prefersStatusBarHidden: Bool { false }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .all }
}

extension GameViewController: GameViewSceneDelegate {
    func didFinishGame() {
        presenter.finishGame(gameResult: .win)
    }
    
    func didHitBall(points: Int) {
        presenter.update(points: points)
    }
}

extension GameViewController: GameViewProtocol {
    func updateTimerLabel(with text: String) {
        timerLabel.text = text
    }
    
    func updateScoreLabel(with text: String) {
        scoreValueLabel.text = text
    }
    
    func updateLevelLabel(with text: String) {
        levelLabel.text = text
    }
    
    func setupScene(with level: Level) {
        view.layoutIfNeeded()
        
        let padding: CGFloat = 16
        let screenWidth = view.bounds.width
        let gameWidth = screenWidth - (padding * 2)
        let sceneSize = CGSize(width: gameWidth, height: gameWidth)
        
        let scene = GameScene(
            size: sceneSize,
            level: level
        )
        scene.sceneDelegate = self
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .clear
        
        gameView.presentScene(scene, transition: .fade(withDuration: 0.15))
    }
    
    func resumeGame() {
        if let scene = self.gameView.scene as? GameScene {
            scene.resumeGame()
        }
    }
    
    func finishGame() {
        if let scene = self.gameView.scene as? GameScene {
            scene.pauseGame()
        }
    }
}
