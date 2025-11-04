//
//  PurchaseViewController.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 29/10/2025.
//

import UIKit

protocol PurchaseViewProtocol: AnyObject {}

class PurchaseViewController: UIViewController, PurchaseViewProtocol {
    
    private let presenter: PurchasePresenter
    
    private let containerView: GradientView = {
        let view = GradientView()
        view.layer.cornerRadius = 51
        view.layer.masksToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .chalkboard(size: 28)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let cancelLabel: UILabel = {
        let label = UILabel()
        label.font = .chalkboard(size: 26)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 21
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let confirmLabel: UILabel = {
        let label = UILabel()
        label.font = .chalkboard(size: 26)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 21
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        return label
    }()
        
    init(
        presenter: PurchasePresenter,
        showBothButtons: Bool = true
    ) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        configureButtons()
    }

    private func setupViews() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        [
            containerView
        ].forEach(view.addView)
        
        [
            titleLabel,
            buttonsStackView
        ].forEach(containerView.addView)
        
        if presenter.canPurchase {
            configureForPurchase()
        } else {
            configureForCancel()
        }
        
        containerView.configureGradient(
            colors: [
                .blueGradientFirst,
                .blueGradientSecond
            ]
        )
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -43),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 27),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            buttonsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35),
            buttonsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 28),
            buttonsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -28),
            buttonsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -35),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    private func configureForPurchase() {
        [
            confirmLabel,
            cancelLabel
        ].forEach(buttonsStackView.addArrangedSubview)
        
        confirmLabel.backgroundColor = UIColor(resource: .greenGradientFirst)
        confirmLabel.text = "YES"
        
        cancelLabel.backgroundColor = UIColor(resource: .appGray)
        cancelLabel.text = "NO"

        titleLabel.text = "DO YOU WANT WANT TO PURCHASE THE ITEM?"
    }
    
    private func configureForCancel() {
        buttonsStackView.addArrangedSubview(cancelLabel)
        
        cancelLabel.backgroundColor = UIColor(resource: .appGray)
        cancelLabel.text = "CLOSE"
        
        titleLabel.text = "YOU DON'T HAVE ENOUGH REWARDS"
    }
    
    private func configureButtons() {
        let confirmTapGesture = UITapGestureRecognizer(target: self, action: #selector(confirmPurchase))
        confirmLabel.addGestureRecognizer(confirmTapGesture)
        
        let cancelTapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelPurchase))
        cancelLabel.addGestureRecognizer(cancelTapGesture)
    }
    
    @objc private func confirmPurchase() {
        presenter.purchaseItem()
    }
    
    @objc private func cancelPurchase() {
        presenter.coordinator.dismiss()
    }
}
