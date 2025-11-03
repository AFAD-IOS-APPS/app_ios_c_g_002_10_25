//
//  RegisterPresenter.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 20/10/2025.
//

import Foundation

final class RegisterPresenter {
    weak var view: RegisterViewProtocol?
    var coordinator: RegisterCoordinator
    
    init(coordinator: RegisterCoordinator) {
        self.coordinator = coordinator
    }
    
    private var name: String = ""
    
    func updateName(with text: String) {
        self.name = text
    }
    
    func finishRegistration() {
        UserDefaultsManager.shared.name = name
        coordinator.finishRegistration()
    }
}
