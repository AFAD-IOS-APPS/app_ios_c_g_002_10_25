//
//  LevelsCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import UIKit

final class LevelsCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showLevelsScreen()
    }
    
    func showGameScreen(levelIndex: Int) {
        let gameCoordinator = GameCoordinator(navigationController: navigationController)
        gameCoordinator.start(levelIndex: levelIndex)
    }
    
    func showGuideScreen() {
        let guideCoordinator = GuideCoordinator(navigationController: navigationController)
        guideCoordinator.start()
    }
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }

    private func showLevelsScreen() {
        let presenter = LevelsPresenter(coordinator: self)
        let view = LevelsViewController(presenter: presenter)
        presenter.view = view
        navigationController.pushViewController(view, animated: true)
    }
}
