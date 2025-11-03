//
//  UIFont+Extension.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 27/10/2025.
//

import UIKit

extension UIFont {
    enum ChalkboardWeight {
        case regular, bold
    }
    
    enum SFProWeight {
        case bold, black
    }
    
    
    static func chalkboard(
        size: CGFloat,
        weight: ChalkboardWeight = .bold
    ) -> UIFont {
        let name: String
        
        switch weight {
        case .regular: 
            name = "ChalkboardSE-Regular"
        case .bold: 
            name = "ChalkboardSE-Bold"
        }
        return UIFont(name: name, size: size)!
    }
    
    static func sfPro(
        size: CGFloat,
        weight: SFProWeight = .bold
    ) -> UIFont {
        let uiWeight: UIFont.Weight
        switch weight {
        case .bold:
            uiWeight = .bold
        case .black:
            uiWeight = .black
        }
        return UIFont.systemFont(ofSize: size, weight: uiWeight)
    }
}
