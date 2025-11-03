//
//  GamePresenter.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 23/10/2025.
//

import UIKit

final class GamePresenter {
    weak var view: GameViewProtocol?
    var coordinator: GameCoordinator
    
    private var levelIndex: Int
    private var displayLink: CADisplayLink?
    private var lastUpdateTime: CFTimeInterval = 0
    private var seconds: Double = 0
    private var isPausedManually = false
    
    private var score: Int = 0
        
    init(
        coordinator: GameCoordinator,
        levelIndex: Int
    ) {
        self.coordinator = coordinator
        self.levelIndex = levelIndex
    }
    
    func startGame() {
        guard displayLink == nil else { return }
        guard let level = LevelsLoader.shared.levelAt(index: levelIndex) else {
            coordinator.dismiss()
            return
        }
        lastUpdateTime = CACurrentMediaTime()
        updateTimerLabel()
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateTimer))
        displayLink?.add(to: .main, forMode: .common)
        
        seconds = Double(level.timeLimit)
        view?.updateLevelLabel(with: level.name)
        view?.setupScene(with: level)
    }

    func pauseGame() {
        guard !isPausedManually else { return }
        isPausedManually = true
        displayLink?.isPaused = true
        coordinator.pauseGame(delegate: self)
    }

    func resumeGame() {
        guard isPausedManually else { return }
        isPausedManually = false
        lastUpdateTime = CACurrentMediaTime()
        displayLink?.isPaused = false
    }

    func finishGame(gameResult: GameResult) {
        guard let level = LevelsLoader.shared.levelAt(index: levelIndex) else { return }

        displayLink?.invalidate()
        displayLink = nil
                
        coordinator.showScoreScreen(
            inputData: .init(
                gameResult: gameResult,
                score: score,
                reward: level.reward
            ),
            delegate: self
        )
        updateProgress(
            gameResult: gameResult,
            reward: level.reward
        )
    }
    
    func update(points: Int) {
        score += points
        view?.updateScoreLabel(with: "\(score)")
    }
    
    private func updateTimerLabel() {
        let intSeconds = Int(seconds)
        let minutes = intSeconds / 60
        let seconds = intSeconds % 60
        let text = String(format: "%d:%02d", minutes, seconds)
        view?.updateTimerLabel(with: text)
    }
    
    private func updateProgress(
        gameResult: GameResult,
        reward: Int
    ) {
        switch gameResult {
        case .win:
            if levelIndex == UserDefaultsManager.shared.progress {
                UserDefaultsManager.shared.progress += 1
            }
            UserDefaultsManager.shared.balance += reward
            levelIndex += 1
        case .lost:
            break
        }
        
    }
    
    private func resetScore() {
        self.score = 0
        view?.updateScoreLabel(with: "\(score)")
    }
    
    @objc private func updateTimer(_ link: CADisplayLink) {
        guard !isPausedManually else { return }
        let currentTime = CACurrentMediaTime()
        let delta = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        
        seconds -= delta
        if seconds <= 0 {
            seconds = 0
            finishGame(gameResult: .lost)
            view?.finishGame()
        }
        updateTimerLabel()
    }
    
    deinit {
        displayLink?.invalidate()
        displayLink = nil
    }
}

extension GamePresenter: PausePresenterDelegate {
    func didResumeGame() {
        resumeGame()
        view?.resumeGame()
    }
}

extension GamePresenter: ScorePresenterDelegate {
    func returnToGame(isReplay: Bool) {
        coordinator.returnToGame()
        resetScore()
        startGame()
    }
}
