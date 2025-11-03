//
//  PurchasePresenter.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 29/10/2025.
//

import Foundation

protocol PurchasePresenterDelegate: AnyObject {
    func didPurchaseItem()
}

final class PurchasePresenter {
    weak var view: PurchaseViewProtocol?
    weak var delegate: PurchasePresenterDelegate?
    var coordinator: PurchaseCoordinator
    
    private var item: StoreItemType
    
    var canPurchase: Bool {
        price <= UserDefaultsManager.shared.balance
    }
    
    private var price: Int {
        switch item {
        case let .skin(skinType):
            skinType.price
        case let .board(boardType):
            boardType.price
        }
    }
    
    init(
        coordinator: PurchaseCoordinator,
        item: StoreItemType
    ) {
        self.coordinator = coordinator
        self.item = item
    }
    
    func purchaseItem() {
        switch item {
        case let .skin(skinType):
            UserDefaultsManager.shared.balance -= skinType.price
            UserDefaultsManager.shared.addPurchasedSkin(id: skinType.id)
        case let .board(boardType):
            UserDefaultsManager.shared.balance -= boardType.price
            UserDefaultsManager.shared.addPurchasedBoard(id: boardType.id)
        }
        delegate?.didPurchaseItem()
        coordinator.dismiss()
    }
}


