//
//  Coordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func childDidFinish(_ child: Coordinator)
}

extension Coordinator {
    func childDidFinish(_ child: Coordinator) {}
}
