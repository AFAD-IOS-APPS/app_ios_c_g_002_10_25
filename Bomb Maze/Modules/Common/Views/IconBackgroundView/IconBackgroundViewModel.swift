//
//  IconBackgroundViewModel.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 21/10/2025.
//

import UIKit

struct IconBackgroundViewModel {
    let backgroundColors: [UIColor]
    let cornerRadius: CGFloat
    let icon: UIImage
    let iconSize: CGSize
    let onTap: (() -> Void)?
    
    init(
        backgroundColors: [UIColor] = [],
        cornerRadius: CGFloat,
        icon: UIImage,
        iconSize: CGSize,
        onTap: (() -> Void)?
    ) {
        self.backgroundColors = backgroundColors
        self.cornerRadius = cornerRadius
        self.icon = icon
        self.iconSize = iconSize
        self.onTap = onTap
    }
}
