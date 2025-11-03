//
//  GuidePresenter.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 31/10/2025.
//

import Foundation

final class GuidePresenter {
    weak var view: GuideViewProtocol?
    let coordinator: GuideCoordinator
    
    init(coordinator: GuideCoordinator) {
        self.coordinator = coordinator
    }
}

