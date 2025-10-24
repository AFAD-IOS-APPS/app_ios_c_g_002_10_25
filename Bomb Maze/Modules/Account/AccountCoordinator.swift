//
//  AccountCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import UIKit

final class AccountCoordinator: Coordinator {
    weak var parentCoordinator: HomeCoordinator?
    private let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showAccountScreen()
    }
    
    func dismiss() {
        parentCoordinator?.childDidFinish(self)
        navigationController.dismiss(animated: true)
    }

    private func showAccountScreen() {
        let presenter = AccountPresenter()
        let view = AccountViewController(presenter: presenter)
        presenter.view = view
        presenter.coordinator = self
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overFullScreen
        navigationController.present(view, animated: true)
    }
}
