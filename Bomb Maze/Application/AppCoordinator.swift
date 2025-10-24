//
//  AppCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 20/10/2025.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        navigationController.setNavigationBarHidden(true, animated: false)
        window.overrideUserInterfaceStyle = .light
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        if let _ = UserDefaultsManager.shared.name {
            showMain()
        } else {
            showRegister()
        }
    }
    
    private func showMain() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
    
    private func showRegister() {
        let registerCoordinator = RegisterCoordinator(navigationController: navigationController)
        registerCoordinator.parentCoordinator = self
        childCoordinators.append(registerCoordinator)
        registerCoordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator) {
        childCoordinators.removeAll { $0 === child }
    }
}
