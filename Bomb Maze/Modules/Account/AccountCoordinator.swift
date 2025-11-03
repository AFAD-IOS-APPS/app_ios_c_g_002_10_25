//
//  AccountCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import UIKit

final class AccountCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showAccountScreen()
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }

    private func showAccountScreen() {
        let presenter = AccountPresenter(coordinator: self)
        let view = AccountViewController(presenter: presenter)
        presenter.view = view
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overFullScreen
        navigationController.present(view, animated: true)
    }
}
