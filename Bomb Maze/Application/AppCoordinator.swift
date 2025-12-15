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
        showSplash()
    }
    
    func showWeb() {
        let webCoordinator = WebCoordinator(navigationController: navigationController)
        webCoordinator.start()
    }
    
    private func setupWindow() {
        navigationController.setNavigationBarHidden(true, animated: false)
        window.overrideUserInterfaceStyle = .light
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func showSplash() {
        let splashCoordinator = SplashCoordinator(navigationController: navigationController)
        splashCoordinator.parentCoordinator = self
        splashCoordinator.start()
    }
}
