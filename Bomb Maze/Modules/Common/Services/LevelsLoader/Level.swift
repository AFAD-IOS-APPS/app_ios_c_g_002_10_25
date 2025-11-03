//
//  Level.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 27/10/2025.
//

import Foundation

struct Level: Codable {
    let name: String
    let timeLimit: Int
    let reward: Int
    
    let lines: [LineConfiguration]
    let balls: [BallConfiguration]
    let spikeBall: SpikeBallConfiguration
}

struct LineConfiguration: Codable {
    let a: Double
    let b: Double
    let c: Double
    let d: Double
}

struct BallConfiguration: Codable {
    let a: Double
    let b: Double
    let d: Double
}

struct SpikeBallConfiguration: Codable {
    let a: Double
    let b: Double
}
