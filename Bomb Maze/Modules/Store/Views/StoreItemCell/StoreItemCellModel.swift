//
//  StoreItemCellModel.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 29/10/2025.
//

import UIKit

struct StoreItemCellModel {
    let image: UIImage
    let priceText: String
    let backgroundColor: UIColor
    let showCurrency: Bool
    
    init(
        image: UIImage,
        priceText: String,
        backgroundColor: UIColor,
        showCurrency: Bool = false
    ) {
        self.image = image
        self.priceText = priceText
        self.backgroundColor = backgroundColor
        self.showCurrency = showCurrency
    }
}
