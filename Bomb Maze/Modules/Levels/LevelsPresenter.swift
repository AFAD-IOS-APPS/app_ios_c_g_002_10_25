//
//  LevelsPresenter.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import Foundation

final class LevelsPresenter {
    weak var view: LevelsViewProtocol?
    weak var coordinator: LevelsCoordinator?
        
    
    func didChooseLevel(level: Level) {
        coordinator?.showGameScreen()
    }
}
