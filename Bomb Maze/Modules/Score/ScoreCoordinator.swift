//
//  ScoreCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 27/10/2025.
//

import UIKit

final class ScoreCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(
        inputData: ScoreInputData,
        delegate: ScorePresenterDelegate?
    ) {
        showScoreScreen(
            inputData: inputData,
            delegate: delegate
        )
    }
    
    func showLevels() {
        navigationController.dismiss(animated: true) { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
    }

    private func showScoreScreen(
        inputData: ScoreInputData,
        delegate: ScorePresenterDelegate?
    ) {
        let presenter = ScorePresenter(
            coordinator: self,
            inputData: inputData
        )
        let view = ScoreViewController(presenter: presenter)
        presenter.view = view
        presenter.delegate = delegate
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overFullScreen
        navigationController.present(view, animated: true)
    }
}
