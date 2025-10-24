//
//  LevelsCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import UIKit

final class LevelsCoordinator: Coordinator {
    weak var parentCoordinator: HomeCoordinator?
    private let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showLevelsScreen()
    }
    
    func showGameScreen() {
        let gameCoordinator = GameCoordinator(navigationController: navigationController)
        gameCoordinator.parentCoordinator = self
        childCoordinators.append(gameCoordinator)
        gameCoordinator.start()
    }
    
    func dismiss() {
        parentCoordinator?.childDidFinish(self)
        navigationController.popViewController(animated: true)
    }

    private func showLevelsScreen() {
        let presenter = LevelsPresenter()
        let view = LevelsViewController(presenter: presenter)
        presenter.view = view
        presenter.coordinator = self
        navigationController.pushViewController(view, animated: true)
    }
}
