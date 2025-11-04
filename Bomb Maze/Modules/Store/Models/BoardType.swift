//
//  BoardType.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 29/10/2025.
//

import UIKit

enum BoardType: CaseIterable, Identifiable {
    case blue
    case green
    case pink
    case red
    case teal
    case black
    
    var id: String { String(describing: self) }
    
    var isPurchased: Bool {
        UserDefaultsManager.shared.purchasedBoardIds.contains(self.id)
    }
    
    var isSelected: Bool {
        self.id == UserDefaultsManager.shared.selectedBoardId
    }
    
    var gameImage: UIImage {
        switch self {
        case .blue:
            return .gameBlueBoard
        case .green:
            return .gameGreenBoard
        case .pink:
            return .gamePinkBoard
        case .red:
            return .gameRedBoard
        case .teal:
            return .gameTealBoard
        case .black:
            return .gameBlackBoard
        }
    }
    
    var storeImage: UIImage {
        switch self {
        case .blue:
            return .storeBlueBoard
        case .green:
            return .storeGreenBoard
        case .pink:
            return .storePinkBoard
        case .red:
            return .storeRedBoard
        case .teal:
            return .storeTealBoard
        case .black:
            return .storeBlackBoard
        }
    }
    
    var price: Int {
        switch self {
        case .blue:
            return 0
        case .green:
            return 500
        case .pink:
            return 2000
        case .red:
            return 3000
        case .teal:
            return 4500
        case .black:
            return 6000
        }
    }
    
    var color: UIColor {
        switch self {
        case .blue:
            return UIColor(resource: .appBlue)
        case .green:
            return UIColor(resource: .appGreen)
        case .pink:
            return UIColor(resource: .appPink)
        case .red:
            return UIColor(resource: .appRed)
        case .teal:
            return UIColor(resource: .appTeal)
        case .black:
            return .white
        }
    }
}

