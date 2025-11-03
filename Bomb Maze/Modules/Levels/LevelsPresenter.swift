//
//  LevelsPresenter.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import Foundation

final class LevelsPresenter {
    weak var view: LevelsViewProtocol?
    let coordinator: LevelsCoordinator
    
    init(coordinator: LevelsCoordinator) {
        self.coordinator = coordinator
    }
        
    func didChooseLevel(index: Int) {
        if index <= UserDefaultsManager.shared.progress {
            coordinator.showGameScreen(levelIndex: index)
        }
    }
}
