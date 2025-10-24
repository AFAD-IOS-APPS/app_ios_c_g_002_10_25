//
//  Colors.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 20/10/2025.
//

import UIKit

enum Colors: String {
    case blueGradientFirstColor
    case blueGradientSecondColor
    case greenGradientFirstColor
    case greenGradientSecondColor
    case magentaGradientFirstColor
    case magentaGradientSecondColor
    case orangeGradientFirstColor
    case orangeGradientSecondColor
    case redGradientFirstColor
    case redGradientSecondColor
    case gray
    
    var color: UIColor {
        return UIColor(named: self.rawValue) ?? UIColor()
    }
}
