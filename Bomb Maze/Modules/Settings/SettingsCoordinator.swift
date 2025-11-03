//
//  SettingsCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 29/10/2025.
//

import UIKit

final class SettingsCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showSettingsScreen()
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }

    private func showSettingsScreen() {
        let presenter = SettingsPresenter(coordinator: self)
        let view = SettingsViewController(presenter: presenter)
        presenter.view = view
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overFullScreen
        navigationController.present(view, animated: true)
    }
}

