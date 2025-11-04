//
//  PauseCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 25/10/2025.
//

import UIKit

final class PauseCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(delegate: PausePresenterDelegate?) {
        showPauseScreen(delegate: delegate)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }

    private func showPauseScreen(delegate: PausePresenterDelegate?) {
        let presenter = PausePresenter(coordinator: self)
        let view = PauseViewController(presenter: presenter)
        presenter.delegate = delegate
        presenter.view = view
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overFullScreen
        navigationController.present(view, animated: true)
    }
}

