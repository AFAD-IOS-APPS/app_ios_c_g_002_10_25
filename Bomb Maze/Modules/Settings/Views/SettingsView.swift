//
//  SettingsView.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 30/10/2025.
//

import UIKit

class SettingsView: GradientView {
    
    var onVolumeChanged: ((Float) -> Void)?
    
    private let volumeIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .settingsMusic
        return imageView
    }()
    
    private let volumeSlider = VolumeSlider()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.cornerRadius = 56
        layer.masksToBounds = true
        
        [
            volumeIconView,
            volumeSlider
        ].forEach(addView)
        
        configureGradient(
            colors: [
                .blueGradientFirst,
                .blueGradientSecond
            ]
        )
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            volumeIconView.topAnchor.constraint(equalTo: topAnchor, constant: 26),
            volumeIconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -26),
            volumeIconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            volumeIconView.widthAnchor.constraint(equalToConstant: 60),
            volumeIconView.heightAnchor.constraint(equalToConstant: 60),
            
            volumeSlider.leadingAnchor.constraint(equalTo: volumeIconView.trailingAnchor, constant: 12),
            volumeSlider.centerYAnchor.constraint(equalTo: volumeIconView.centerYAnchor),
            volumeSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            volumeSlider.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupActions() {
        volumeSlider.onValueChanged = { [weak self] value in
            self?.onVolumeChanged?(value)
        }
    }
    
    func setVolume(_ volume: Float) {
        volumeSlider.value = volume
    }

}
