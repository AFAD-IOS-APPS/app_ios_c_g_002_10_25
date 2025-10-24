//
//  LevelsLoader.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 23/10/2025.
//

import Foundation

struct Level: Codable {
    let id: String
    let timeLimit: Int
    let points: Int
}

final class LevelsLoader {
    
    static let shared = LevelsLoader()
    
    private init() {}
    
    func loadLevels() -> [Level] {
        guard let url = Bundle.main.url(forResource: "levels", withExtension: "json") else {
            print("❌ levels.json not found in bundle")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            let levels = try JSONDecoder().decode([Level].self, from: data)
            return levels
        } catch {
            print("❌ Failed to decode levels.json:", error)
            return []
        }
    }
}
