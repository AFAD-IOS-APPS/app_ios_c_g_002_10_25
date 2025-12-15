//
//  RegisterCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 20/10/2025.
//

import UIKit

final class RegisterCoordinator {
    weak var parentCoordinator: WebCoordinator?
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showRegisterScreen()
    }

    private func showRegisterScreen() {
        let presenter = RegisterPresenter(coordinator: self)
        let view = RegisterViewController(presenter: presenter)
        presenter.view = view
        navigationController.pushViewController(view, animated: true)
    }

    func finishRegistration() {
        parentCoordinator?.startMainFlow()
    }
}
