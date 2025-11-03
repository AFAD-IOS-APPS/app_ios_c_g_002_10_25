//
//  StoreCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 28/10/2025.
//

import UIKit

final class StoreCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showStoreScreen()
    }
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
    
    func showPurchaseScreen(
        item: StoreItemType,
        delegate: PurchasePresenterDelegate?
    ) {
        let purchaseCoordinator = PurchaseCoordinator(navigationController: navigationController)
        purchaseCoordinator.start(
            item: item,
            delegate: delegate
        )
    }

    private func showStoreScreen() {
        let presenter = StorePresenter(coordinator: self)
        let view = StoreViewController(presenter: presenter)
        presenter.view = view
        navigationController.pushViewController(view, animated: true)
    }
}

