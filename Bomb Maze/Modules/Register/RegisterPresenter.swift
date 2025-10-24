//
//  RegisterPresenter.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 20/10/2025.
//

import Foundation

final class RegisterPresenter {
    weak var view: RegisterViewProtocol?
    weak var coordinator: RegisterCoordinator?
    
    private var name: String = ""
    
    func updateName(with text: String) {
        self.name = text
    }
    
    func finishRegistration() {
        UserDefaultsManager.shared.name = name
        coordinator?.finishRegistration()
    }
    
    deinit {
        print("I'm deleted!")
    }
}
