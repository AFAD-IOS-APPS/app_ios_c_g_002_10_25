//
//  SplashCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 03/11/2025.
//

import UIKit

final class SplashCoordinator {
    weak var parentCoordinator: AppCoordinator?
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let splashVC = SplashViewController(coordinator: self)
        navigationController.setViewControllers([splashVC], animated: false)
    }
    
    func startMainFlow() {
        parentCoordinator?.startMainFlow()
    }
}
