//
//  Assets.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 20/10/2025.
//

import UIKit

enum Assets: String {
    case launchScreen
    case homeScreen
    case levelsScreen
    case gameScreen
    case loading
    case play
    case levels
    case settings
    case account
    case store
    case edit
    case check
    case cross
    case back
    case spikeBall
    case blueField
    case pinkBall
    
    var image: UIImage {
        return UIImage(named: self.rawValue) ?? UIImage()
    }
}
