//
//  SkinType.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 29/10/2025.
//

import UIKit

enum SkinType: CaseIterable, Identifiable {
    case silver
    case red
    case pink
    case teal
    case blue
    case lightBlue
    
    var id: String { String(describing: self) }
    
    var isPurchased: Bool {
        UserDefaultsManager.shared.purchasedSkinIds.contains(self.id)
    }
    
    var isSelected: Bool {
        self.id == UserDefaultsManager.shared.selectedSkinId
    }
    
    var image: UIImage {
        switch self {
        case .silver:
            return .silverSpikeBall
        case .red:
            return .redSpikeBall
        case .pink:
            return .pinkSpikeBall
        case .teal:
            return .tealSpikeBall
        case .blue:
            return .blueSpikeBall
        case .lightBlue:
            return .lightBlueSpikeBall
        }
    }
    
    var price: Int {
        switch self {
        case .silver:
            return 0
        case .red:
            return 1000
        case .pink:
            return 1500
        case .teal:
            return 2500
        case .blue:
            return 5000
        case .lightBlue:
            return 10000
        }
    }
}
