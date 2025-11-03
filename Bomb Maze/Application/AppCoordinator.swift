//
//  AppCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 20/10/2025.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let navigationController: UINavigationController
        
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        setupWindow()
    }
    
    func start() {
        if let _ = UserDefaultsManager.shared.name {
            showHome()
        } else {
            showRegister()
        }
    }
    
    private func setupWindow() {
        navigationController.setNavigationBarHidden(true, animated: false)
        window.overrideUserInterfaceStyle = .light
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
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
