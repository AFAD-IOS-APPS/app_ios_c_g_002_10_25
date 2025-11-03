//
//  ScorePresenter.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 27/10/2025.
//

import UIKit

protocol ScorePresenterDelegate: AnyObject {
    func returnToGame(isReplay: Bool)
}

final class ScorePresenter {
    weak var view: ScoreViewProtocol?
    weak var delegate: ScorePresenterDelegate?
    var coordinator: ScoreCoordinator
    
    private let inputData: ScoreInputData
    
    var gameResult: GameResult { inputData.gameResult }
        
    init(
        coordinator: ScoreCoordinator,
        inputData: ScoreInputData
    ) {
        self.coordinator = coordinator
        self.inputData = inputData
    }
    
    func handleGameFinish() {
        let isReplay = gameResult == .lost
        delegate?.returnToGame(isReplay: isReplay)
    }
    
    func getScoreModel() -> ScoreViewModel {
        let reward = switch gameResult {
        case .win:
            inputData.reward
        case .lost:
            0
        }
        
        return ScoreViewModel(
            gameResult: inputData.gameResult,
            score: inputData.score,
            reward: reward
        )
    }
}

