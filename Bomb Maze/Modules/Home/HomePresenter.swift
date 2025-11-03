//
//  HomePresenter.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 21/10/2025.
//

import Foundation

final class HomePresenter {
    weak var view: HomeViewProtocol?
    var coordinator: HomeCoordinator
    
    var isMusicEnabled: Bool { UserDefaultsManager.shared.isMusicEnabled }
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func toggleMusic() {
        MusicManager.shared.toggleMusic()
    }
}
