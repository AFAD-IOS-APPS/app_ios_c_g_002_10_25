//
//  HomeCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 21/10/2025.
//

import UIKit

final class HomeCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showHomeScreen()
    }

    private func showHomeScreen() {
        let presenter = HomePresenter(coordinator: self)
        let view = HomeViewController(presenter: presenter)
        presenter.view = view
        navigationController.setViewControllers([view], animated: true)
    }
    
    func showSettings() {
        let settingsCoordinator = SettingsCoordinator(navigationController: navigationController)
        settingsCoordinator.start()
    }
    
    func showStore() {
        let storeCoordinator = StoreCoordinator(navigationController: navigationController)
        storeCoordinator.start()
    }
    
    func showAccountInfo() {
        let accountCoordinator = AccountCoordinator(navigationController: navigationController)
        accountCoordinator.start()
    }
    
    func showLevels() {
        let levelsCoordinator = LevelsCoordinator(navigationController: navigationController)
        levelsCoordinator.start()
    }
}
