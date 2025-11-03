//
//  LevelsViewController.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import UIKit

protocol LevelsViewProtocol: AnyObject {}

final class LevelsViewController: UIViewController, LevelsViewProtocol {
    private let presenter: LevelsPresenter
    
    private let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .levelsScreen
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = .back
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "LEVELS"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = .chalkboard(size: 48)
        return label
    }()
    
    private let levelsView = LevelsView()
    
    private let guideImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = .guide
        return imageView
    }()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        levelsView.reloadCollectionView()
    }
    
    private func setupViews() {
        [
            backgroundView,
            backImageView,
            guideImageView,
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
            
            guideImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            guideImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            guideImageView.widthAnchor.constraint(equalToConstant: 62),
            guideImageView.heightAnchor.constraint(equalToConstant: 62),
            
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
        levelsView.configure(levelsCount: LevelsLoader.shared.levelsCounts)
        levelsView.delegate = self
    }
    
    private func configureIcons() {
        let backRecognizer = UITapGestureRecognizer(target: self, action: #selector(back))
        backImageView.addGestureRecognizer(backRecognizer)
        
        let guideRecognizer = UITapGestureRecognizer(target: self, action: #selector(openGuide))
        guideImageView.addGestureRecognizer(guideRecognizer)
    }
    
    @objc private func back() {
        presenter.coordinator.dismiss()
    }
    
    @objc private func openGuide() {
        presenter.coordinator.showGuideScreen()
    }
}

extension LevelsViewController: LevelsViewDelegate {
    func didChooseLevel(index: Int) {
        presenter.didChooseLevel(index: index)
    }
}
