//
//  PausePresenter.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 25/10/2025.
//

import Foundation

protocol PausePresenterDelegate: AnyObject {
    func didResumeGame()
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
        coordinator.resumeGame()
    }
    
    func toggleMusic() {
        MusicManager.shared.toggleMusic()
    }
}

