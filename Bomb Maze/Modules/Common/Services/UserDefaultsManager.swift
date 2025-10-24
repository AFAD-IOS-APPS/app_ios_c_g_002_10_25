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
    
    private init() {}
    
    private enum Keys: String {
        case name
        case age
        case balance
        case progress
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
}

