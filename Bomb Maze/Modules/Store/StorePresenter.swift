//
//  StorePresenter.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 28/10/2025.
//

import UIKit

final class StorePresenter {
    weak var view: StoreViewProtocol?
    var coordinator: StoreCoordinator
    
    init(coordinator: StoreCoordinator) {
        self.coordinator = coordinator
    }
    
    func setupRewardsBalance() {
        let balance = String(UserDefaultsManager.shared.balance)
        view?.updateRewardsLabel(with: balance)
    }
        
    func configure(type: StoreItemType) -> StoreItemCellModel {
        switch type {
        case let .skin(skinType):
            if skinType.isPurchased {
                let priceText = skinType.isSelected 
                ? "Selected"
                : "Equip"
                
                let backgroundColor = skinType.isSelected
                ? UIColor(resource: .pink)
                : UIColor(resource: .greenGradientFirst)
                
                return StoreItemCellModel(
                    image: skinType.image,
                    priceText: priceText,
                    backgroundColor: backgroundColor
                )
            } else {
                return StoreItemCellModel(
                    image: skinType.image,
                    priceText: "\(skinType.price)",
                    backgroundColor: UIColor(resource: .greenGradientFirst),
                    showCurrency: true
                )
            }
        case let .board(boardType):
            if boardType.isPurchased {
                let priceText = boardType.isSelected
                ? "Selected"
                : "Equip"
                
                let backgroundColor = boardType.isSelected
                ? UIColor(resource: .pink)
                : UIColor(resource: .greenGradientFirst)
                
                return StoreItemCellModel(
                    image: boardType.storeImage,
                    priceText: priceText,
                    backgroundColor: backgroundColor
                )
            } else {
                return StoreItemCellModel(
                    image: boardType.storeImage,
                    priceText: "\(boardType.price)",
                    backgroundColor: UIColor(resource: .greenGradientFirst),
                    showCurrency: true
                )
            }
        }
    }
    
    func didSelect(item: StoreItemType) {
        switch item {
        case let .skin(skinType):
            if skinType.isPurchased {
                if !skinType.isSelected {
                    UserDefaultsManager.shared.selectedSkinId = skinType.id
                    view?.reloadSkinsCollectionView()
                }
            } else {
                coordinator.showPurchaseScreen(
                    item: item,
                    delegate: self
                )
            }
        case let .board(boardType):
            if boardType.isPurchased {
                if !boardType.isSelected {
                    UserDefaultsManager.shared.selectedBoardId = boardType.id
                    view?.reloadBoardsCollectionView()
                }
            } else {
                coordinator.showPurchaseScreen(
                    item: item,
                    delegate: self
                )
            }
        }
    }
}

extension StorePresenter: PurchasePresenterDelegate {
    func didPurchaseItem() {
        let balance = String(UserDefaultsManager.shared.balance)
        
        view?.updateRewardsLabel(with: balance)
        view?.reloadSkinsCollectionView()
        view?.reloadBoardsCollectionView()
    }
}

