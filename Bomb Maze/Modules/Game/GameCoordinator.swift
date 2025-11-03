//
//  GameCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 23/10/2025.
//

import UIKit

final class GameCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(levelIndex: Int) {
        showGameScreen(levelIndex: levelIndex)
    }
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
    
    func returnToGame() {
        navigationController.dismiss(animated: true)
    }
    
    func pauseGame(delegate: PausePresenterDelegate?) {
        let pauseCoordinator = PauseCoordinator(navigationController: navigationController)
        pauseCoordinator.start(delegate: delegate)
    }
    
    func showScoreScreen(
        inputData: ScoreInputData,
        delegate: ScorePresenterDelegate?
    ) {
        let scoreCoordinator = ScoreCoordinator(navigationController: navigationController)
        scoreCoordinator.start(
            inputData: inputData,
            delegate: delegate
        )
    }

    private func showGameScreen(levelIndex: Int) {
        let presenter = GamePresenter(
            coordinator: self,
            levelIndex: levelIndex
        )
        let view = GameViewController(presenter: presenter)
        presenter.view = view
        navigationController.pushViewController(view, animated: false)
    }
}
