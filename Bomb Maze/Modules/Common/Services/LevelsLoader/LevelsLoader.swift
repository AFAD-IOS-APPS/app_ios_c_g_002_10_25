//
//  LevelsLoader.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 23/10/2025.
//

import Foundation

final class LevelsLoader {
    
    static let shared = LevelsLoader()
    
    private var levels: [Level] = []
    
    var levelsCounts: Int { levels.count }
    
    private init() {}
    
    func loadLevels() {
        guard let url = Bundle.main.url(forResource: "levels", withExtension: "json") else {
            print("File not found in bundle")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let levels = try JSONDecoder().decode([Level].self, from: data)
            self.levels = levels
        } catch {
            print("Decoding error", error)
        }
    }
    
    func levelAt(index: Int) -> Level? {
        guard index >= 0, index < levels.count else { return nil }
        return levels[index]
    }
}
