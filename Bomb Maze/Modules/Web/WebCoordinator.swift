//
//  WebCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 10/12/2025.
//

import UIKit

final class WebCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let presenter = WebPresenter(coordinator: self)
        let view = WebViewController(presenter: presenter)
        presenter.view = view
        navigationController.setViewControllers([view], animated: true)
    }
    
    func startMainFlow() {
        if let _ = UserDefaultsManager.shared.name {
            showHome()
        } else {
            showRegister()
        }
    }
    
    private func showHome() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }
    
    private func showRegister() {
        let registerCoordinator = RegisterCoordinator(navigationController: navigationController)
        registerCoordinator.parentCoordinator = self
        registerCoordinator.start()
    }
}
