//
//  RegisterCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 20/10/2025.
//

import UIKit

final class RegisterCoordinator: Coordinator {
    weak var parentCoordinator: AppCoordinator?
    private let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showRegisterScreen()
    }

    private func showRegisterScreen() {
        let presenter = RegisterPresenter()
        let view = RegisterViewController(presenter: presenter)
        presenter.view = view
        presenter.coordinator = self
        navigationController.setViewControllers([view], animated: false)
    }

    func finishRegistration() {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.start()
    }
}

