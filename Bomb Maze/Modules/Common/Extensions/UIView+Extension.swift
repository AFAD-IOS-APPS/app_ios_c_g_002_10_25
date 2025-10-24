//
//  UIView+Extension.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import UIKit

extension UIView {
    func addView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
}
