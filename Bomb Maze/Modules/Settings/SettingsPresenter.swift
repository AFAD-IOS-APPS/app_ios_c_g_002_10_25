//
//  SettingsPresenter.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 30/10/2025.
//

import Foundation

final class SettingsPresenter {
    weak var view: SettingsViewProtocol?
    var coordinator: SettingsCoordinator
    
    init(coordinator: SettingsCoordinator) {
        self.coordinator = coordinator
    }
    
    func getVolume() -> Float {
        MusicManager.shared.getVolume()
    }
    
    func setVolume(_ volume: Float) {
        MusicManager.shared.setVolume(volume)
    }
}

