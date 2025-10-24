//
//  HomeCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 21/10/2025.
//

import UIKit

final class HomeCoordinator: Coordinator {
    private let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showHomeScreen()
    }

    private func showHomeScreen() {
        let presenter = HomePresenter()
        let view = HomeViewController(presenter: presenter)
        presenter.view = view
        presenter.coordinator = self
        navigationController.setViewControllers([view], animated: true)
    }
    
    func showAccountInfo() {
        let accountCoordinator = AccountCoordinator(navigationController: navigationController)
        accountCoordinator.parentCoordinator = self
        childCoordinators.append(accountCoordinator)
        accountCoordinator.start()
    }
    
    func showLevels() {
        let levelsCoordinator = LevelsCoordinator(navigationController: navigationController)
        levelsCoordinator.parentCoordinator = self
        childCoordinators.append(levelsCoordinator)
        levelsCoordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator) {
        childCoordinators.removeAll { $0 === child }
    }
}
