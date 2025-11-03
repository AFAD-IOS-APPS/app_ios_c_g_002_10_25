//
//  GuideCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 31/10/2025.
//

import UIKit

final class GuideCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showGuideScreen()
    }
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }

    private func showGuideScreen() {
        let presenter = GuidePresenter(coordinator: self)
        let view = GuideViewController(presenter: presenter)
        presenter.view = view
        navigationController.pushViewController(view, animated: true)
    }
}

