//
//  PurchaseCoordinator.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 29/10/2025.
//

import UIKit

final class PurchaseCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(
        item: StoreItemType,
        delegate: PurchasePresenterDelegate?
    ) {
        showPurchaseScreen(
            item: item,
            delegate: delegate
        )
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }

    private func showPurchaseScreen(
        item: StoreItemType,
        delegate: PurchasePresenterDelegate?
    ) {
        let presenter = PurchasePresenter(
            coordinator: self,
            item: item
        )
        let view = PurchaseViewController(presenter: presenter)
        presenter.view = view
        presenter.delegate = delegate
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overFullScreen
        navigationController.present(view, animated: true)
    }
}


