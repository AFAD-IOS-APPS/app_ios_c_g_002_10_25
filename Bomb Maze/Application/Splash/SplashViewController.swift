//
//  SplashViewController.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 03/11/2025.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    private var coordinator: SplashCoordinator
    
    init(coordinator: SplashCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = .homeScreen
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private var animationContainer = UIView()
    private var animationView: LottieAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        setupAnimation()
    }
    
    private func setupViews() {
        [
            backgroundView,
            animationContainer
        ].forEach(view.addView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            animationContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationContainer.widthAnchor.constraint(equalToConstant: 200),
            animationContainer.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func setupAnimation() {
        let animationView = LottieAnimationView(name: "loading")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.backgroundBehavior = .pauseAndRestore
        
        view.layoutIfNeeded()

        animationContainer.addSubview(animationView)
        animationView.frame = animationContainer.bounds

        self.animationView = animationView

        animationView.play { [weak self] finished in
            if finished {
                self?.fadeOutAndFinish()
            }
        }
    }

    private func fadeOutAndFinish() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.animationContainer.alpha = 0
        }, completion: { [weak self] _ in
            self?.animationView?.stop()
            self?.animationView?.removeFromSuperview()
            self?.animationView?.animation = nil
            self?.animationView = nil
            
            self?.coordinator.showWeb()
        })
    }
}

