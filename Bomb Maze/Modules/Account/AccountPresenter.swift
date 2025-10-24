//
//  AccountPresenter.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import Foundation

final class AccountPresenter {
    weak var view: AccountViewProtocol?
    weak var coordinator: AccountCoordinator?
    
    private var name: String = UserDefaultsManager.shared.name ?? ""
    private var age: String = UserDefaultsManager.shared.age ?? ""
        
    func updateName(with text: String) {
        self.name = text
    }
    
    func updateAge(with text: String) {
        self.age = text
    }
    
    func acceptChanges() {
        UserDefaultsManager.shared.name = name
        UserDefaultsManager.shared.age = age
        coordinator?.dismiss()
    }
}
