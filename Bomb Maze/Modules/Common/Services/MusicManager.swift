//
//  MusicManager.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 29/10/2025.
//

import AVFoundation
import UIKit

protocol MusicManagerProtocol {
    func setupNotifications()
    func toggleMusic(_ value: Bool?)
    func setupBackgroundMusic(name: String)
    func setVolume(_ volume: Float)
    func getVolume() -> Float
}

final class MusicManager: MusicManagerProtocol {
    static let shared = MusicManager()
    private var backgroundMusicPlayer: AVAudioPlayer?
    
    private init() {
        setupBackgroundMusic(name: "backgroundMusic")
        setupNotifications()
    }
    
    private var isMusicEnabled: Bool {
        get { UserDefaultsManager.shared.isMusicEnabled }
        set { UserDefaultsManager.shared.isMusicEnabled = newValue }
    }
    
    private var savedVolume: Float {
        get { UserDefaultsManager.shared.musicVolume }
        set { UserDefaultsManager.shared.musicVolume = newValue }
    }
    
    func setVolume(_ volume: Float) {
        backgroundMusicPlayer?.volume = volume
        savedVolume = volume
    }
    
    func getVolume() -> Float {
        return backgroundMusicPlayer?.volume ?? savedVolume
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(pauseMusic),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(resumeMusic),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    @objc private func pauseMusic() {
        backgroundMusicPlayer?.pause()
    }
    
    @objc private func resumeMusic() {
        if isMusicEnabled {
            backgroundMusicPlayer?.play()
        }
    }
    
    func toggleMusic(_ value: Bool? = nil) {
        if let value = value {
            isMusicEnabled = value
        } else {
            isMusicEnabled.toggle()
        }
        
        if isMusicEnabled {
            backgroundMusicPlayer?.play()
        } else {
            backgroundMusicPlayer?.pause()
        }
    }
    
    func setupBackgroundMusic(name: String = "backgroundMusic") {
        guard let musicPath = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("Music file not found: \(name).mp3")
            return
        }
        
        let url = URL(fileURLWithPath: musicPath)
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1
            backgroundMusicPlayer?.volume = savedVolume
            if isMusicEnabled {
                backgroundMusicPlayer?.play()
            }
        } catch {
            print("Error initializing background music: \(error)")
        }
    }
}
