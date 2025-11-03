//
//  SettingsViewController.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 30/10/2025.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {}

class SettingsViewController: UIViewController, SettingsViewProtocol {
    
    private let presenter: SettingsPresenter
    
    private let settingsView = SettingsView()
    
    private let cancelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = .cross
        return imageView
    }()
    
    init(presenter: SettingsPresenter) {
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
        setupCallbacks()
        configureIcons()
        loadCurrentVolume()
    }

    private func setupViews() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        [
            settingsView,
            cancelImageView
        ].forEach(view.addView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            settingsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            
            cancelImageView.widthAnchor.constraint(equalToConstant: 68),
            cancelImageView.heightAnchor.constraint(equalToConstant: 68),
            cancelImageView.topAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: 50),
            cancelImageView.centerXAnchor.constraint(equalTo: settingsView.centerXAnchor),
        ])
    }
    
    private func setupCallbacks() {
        settingsView.onVolumeChanged = { [weak self] volume in
            self?.presenter.setVolume(volume)
        }
    }
    
    private func loadCurrentVolume() {
        let currentVolume = presenter.getVolume()
        settingsView.setVolume(currentVolume)
    }
    
    private func configureIcons() {
        let cancelRecognizer = UITapGestureRecognizer(target: self, action: #selector(cancelChanges))
        cancelImageView.addGestureRecognizer(cancelRecognizer)
    }
    
    @objc private func cancelChanges() {
        presenter.coordinator.dismiss()
    }
}
