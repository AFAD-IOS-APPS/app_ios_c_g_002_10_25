//
//  LevelsViewController.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import UIKit

protocol LevelsViewProtocol: AnyObject {
    
}

final class LevelsViewController: UIViewController, LevelsViewProtocol {
    private let presenter: LevelsPresenter
    
    private let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.levelsScreen.image
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = Assets.back.image
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "LEVELS"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Marker Felt", size: 36) ?? .boldSystemFont(ofSize: 36)
        return label
    }()
    
    private let levelsView = LevelsView()
    
    init(presenter: LevelsPresenter) {
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
        configureLevels()
    }
    
    private func setupViews() {
        [
            backgroundView,
            backImageView,
            titleLabel,
            levelsView
            
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
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: backImageView.bottomAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            levelsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            levelsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            levelsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            levelsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureLevels() {
        let levels = LevelsLoader.shared.loadLevels()
        levelsView.configureLevels(levels: levels)
        levelsView.delegate = self
    }
    
    private func configureIcons() {
        let backRecognizer = UITapGestureRecognizer(target: self, action: #selector(back))
        backImageView.addGestureRecognizer(backRecognizer)
        
    }
    
    @objc private func back() {
        presenter.coordinator?.dismiss()
    }
}

extension LevelsViewController: LevelsViewDelegate {
    func didChooseLevel(level: Level) {
        presenter.didChooseLevel(level: level)
    }
}
