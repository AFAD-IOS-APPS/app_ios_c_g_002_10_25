//
//  UserDefaultsManager.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 21/10/2025.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    private init() {
        UserDefaults.standard.register(
            defaults: [
                Keys.isMusicEnabled.rawValue: true
            ]
        )
    }
    
    private enum Keys: String {
        case name
        case age
        case balance
        case progress
        case selectedSkinId
        case purchasedSkinIds
        case selectedBoardId
        case purchasedBoardIds
        case isMusicEnabled
        case musicVolume
    }
        
    var name: String? {
        get { defaults.string(forKey: Keys.name.rawValue) }
        set { defaults.set(newValue, forKey: Keys.name.rawValue) }
    }
    
    var age: String? {
        get { defaults.string(forKey: Keys.age.rawValue) }
        set { defaults.set(newValue, forKey: Keys.age.rawValue) }
    }
    
    var balance: Int {
        get { defaults.integer(forKey: Keys.balance.rawValue) }
        set { defaults.set(newValue, forKey: Keys.balance.rawValue) }
    }
    
    var progress: Int {
        get { defaults.integer(forKey: Keys.progress.rawValue) }
        set { defaults.set(newValue, forKey: Keys.progress.rawValue) }
    }
    
    var isMusicEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.isMusicEnabled.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.isMusicEnabled.rawValue) }
    }
    
    var musicVolume: Float {
        get { UserDefaults.standard.float(forKey: "musicVolume") == 0 ? 0.7 : UserDefaults.standard.float(forKey: "musicVolume") }
        set { UserDefaults.standard.set(newValue, forKey: "musicVolume") }
    }
    
    var selectedSkinId: String {
        get { defaults.string(forKey: Keys.selectedSkinId.rawValue) ?? SkinType.silver.id }
        set { defaults.set(newValue, forKey: Keys.selectedSkinId.rawValue) }
    }
    
    var purchasedSkinIds: [String] {
        get {
            var skins = defaults.stringArray(forKey: Keys.purchasedSkinIds.rawValue) ?? []
            if !skins.contains(SkinType.silver.id) {
                skins.append(SkinType.silver.id)
            }
            return skins
        }
        set {
            defaults.set(newValue, forKey: Keys.purchasedSkinIds.rawValue)
        }
    }
    
    var selectedBoardId: String {
        get { defaults.string(forKey: Keys.selectedBoardId.rawValue) ?? BoardType.blue.id }
        set { defaults.set(newValue, forKey: Keys.selectedBoardId.rawValue) }
    }
    
    var purchasedBoardIds: [String] {
        get {
            var boards = defaults.stringArray(forKey: Keys.purchasedBoardIds.rawValue) ?? []
            if !boards.contains(BoardType.blue.id) {
                boards.append(BoardType.blue.id)
            }
            return boards
        }
        set { defaults.set(newValue, forKey: Keys.purchasedBoardIds.rawValue) }
    }
}

extension UserDefaultsManager {
    func addPurchasedSkin(id: String) {
        var skins = purchasedSkinIds
        if !skins.contains(id) {
            skins.append(id)
            purchasedSkinIds = skins
        }
    }
    
    func addPurchasedBoard(id: String) {
        var boards = purchasedBoardIds
        if !boards.contains(id) {
            boards.append(id)
            purchasedBoardIds = boards
        }
    }
}

