//
//  PausePresenter.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 25/10/2025.
//

import Foundation

protocol PausePresenterDelegate: AnyObject {
    func didResumeGame()
    func didQuitGame()
}

final class PausePresenter {
    weak var view: PauseViewProtocol?
    weak var delegate: PausePresenterDelegate?
    var coordinator: PauseCoordinator
    
    var isMusicEnabled: Bool { UserDefaultsManager.shared.isMusicEnabled }
    
    init(coordinator: PauseCoordinator) {
        self.coordinator = coordinator
    }
    
    func resumeGame() {
        delegate?.didResumeGame()
        coordinator.dismiss()
    }
    
    func quitGame() {
        delegate?.didQuitGame()
        coordinator.dismiss()
    }
    
    func toggleMusic() {
        MusicManager.shared.toggleMusic()
    }
}

