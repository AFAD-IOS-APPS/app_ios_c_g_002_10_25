//
//  BallColor.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 28/10/2025.
//

import UIKit

enum BallColor: CaseIterable {
    case lightBlue, blue, purple, pink, teal, green, yellow
    
    var image: UIImage {
        switch self {
        case .lightBlue:
                .lighBlueBall
        case .blue:
                .blueBall
        case .purple:
                .purpleBall
        case .pink:
                .pinkBall
        case .teal:
                .tealBall
        case .green:
                .greenBall
        case .yellow:
                .yellowBall
        }
    }
    
    static func random() -> BallColor {
        return BallColor.allCases.randomElement()!
    }
}
