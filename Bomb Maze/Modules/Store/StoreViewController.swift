//
//  StoreViewController.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 28/10/2025.
//

import UIKit

protocol StoreViewProtocol: AnyObject {
    func updateRewardsLabel(with text: String)
    func reloadSkinsCollectionView()
    func reloadBoardsCollectionView()
}

final class StoreViewController: UIViewController {
    private let presenter: StorePresenter
    
    private let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .storeScreen
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .back
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let balanceContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()

    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .currency
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let rewardsBalanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .magentaGradientFirst
        label.font = .sfPro(size: 21)
        label.textAlignment = .center
        return label
    }()
    
    private let skinsLabel: UILabel = {
        let label = UILabel()
        label.text = "SKINS"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .chalkboard(size: 48)
        return label
    }()
    
    private let boardsLabel: UILabel = {
        let label = UILabel()
        label.text = "BOARDS"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .chalkboard(size: 48)
        return label
    }()
    
    private lazy var skinsCollectionView: SelfSizingCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 32
        layout.minimumInteritemSpacing = 36
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let collectionView = SelfSizingCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.tag = 1
        collectionView.register(StoreItemCell.self, forCellWithReuseIdentifier: StoreItemCell.reuseId)
        return collectionView
    }()
    
    private lazy var boardsCollectionView: SelfSizingCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 32
        layout.minimumInteritemSpacing = 36
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let collectionView = SelfSizingCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.tag = 2
        collectionView.register(StoreItemCell.self, forCellWithReuseIdentifier: StoreItemCell.reuseId)
        return collectionView
    }()
    
    init(presenter: StorePresenter) {
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
        configureIcons()
        
        presenter.setupRewardsBalance()
    }
    
    private func setupViews() {
        view.addView(backgroundView)
        view.addView(scrollView)
        scrollView.addView(contentView)
        balanceContainerView.addView(rewardsBalanceLabel)
        
        [
            backImageView,
            balanceContainerView,
            starImageView,
            skinsLabel,
            skinsCollectionView,
            boardsLabel,
            boardsCollectionView
        ].forEach(contentView.addView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            backImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 28),
            backImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            backImageView.widthAnchor.constraint(equalToConstant: 62),
            backImageView.heightAnchor.constraint(equalToConstant: 62),
            
            balanceContainerView.centerYAnchor.constraint(equalTo: backImageView.centerYAnchor),
            balanceContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            balanceContainerView.heightAnchor.constraint(equalToConstant: 30),
            
            starImageView.centerYAnchor.constraint(equalTo: balanceContainerView.centerYAnchor),
            starImageView.leadingAnchor.constraint(equalTo: balanceContainerView.leadingAnchor, constant: -30),
            starImageView.widthAnchor.constraint(equalToConstant: 45),
            starImageView.heightAnchor.constraint(equalToConstant: 45),
            
            rewardsBalanceLabel.centerYAnchor.constraint(equalTo: balanceContainerView.centerYAnchor),
            rewardsBalanceLabel.leadingAnchor.constraint(equalTo: balanceContainerView.leadingAnchor, constant: 20),
            rewardsBalanceLabel.trailingAnchor.constraint(equalTo: balanceContainerView.trailingAnchor, constant: -20),
            
            skinsLabel.topAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: 10),
            skinsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            skinsCollectionView.topAnchor.constraint(equalTo: skinsLabel.bottomAnchor, constant: 8),
            skinsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            skinsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            boardsLabel.topAnchor.constraint(equalTo: skinsCollectionView.bottomAnchor, constant: 24),
            boardsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            boardsCollectionView.topAnchor.constraint(equalTo: boardsLabel.bottomAnchor, constant: 8),
            boardsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            boardsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            boardsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    private func configureIcons() {
        let backRecognizer = UITapGestureRecognizer(target: self, action: #selector(back))
        backImageView.addGestureRecognizer(backRecognizer)
    }
    
    @objc private func back() {
        presenter.coordinator.dismiss()
    }
    
    private func calculateCellSize(for collectionView: UICollectionView) -> CGSize {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        let sectionInset = layout.sectionInset.left + layout.sectionInset.right
        let spacing = layout.minimumInteritemSpacing * 2
        
        let availableWidth = view.bounds.width
        let width = floor((availableWidth - sectionInset - spacing) / 3)
        let height = width + 5 + 32
        return CGSize(width: width, height: height)
    }
}

extension StoreViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        collectionView.tag == 1 ? SkinType.allCases.count : BoardType.allCases.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreItemCell.reuseId, for: indexPath) as? StoreItemCell else {
            return UICollectionViewCell()
        }
        let type: StoreItemType
        let isSkin = collectionView.tag == 1
        
        if isSkin {
            type = .skin(SkinType.allCases[indexPath.item])
        } else {
            type = .board(BoardType.allCases[indexPath.item])
        }
        
        let cellItem = presenter.configure(type: type)
        cell.configure(with: cellItem)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return calculateCellSize(for: collectionView)
    }
}

extension StoreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item: StoreItemType
        
        if collectionView.tag == 1 {
            item = .skin(SkinType.allCases[indexPath.item])
        } else {
            item = .board(BoardType.allCases[indexPath.item])
        }
        
        presenter.didSelect(item: item)
    }
}

extension StoreViewController: StoreViewProtocol {
    func updateRewardsLabel(with text: String) {
        rewardsBalanceLabel.text = text
    }
    
    func reloadSkinsCollectionView() {
        skinsCollectionView.collectionViewLayout.invalidateLayout()
        skinsCollectionView.reloadData()
    }
    
    func reloadBoardsCollectionView() {
        boardsCollectionView.collectionViewLayout.invalidateLayout()
        boardsCollectionView.reloadData()
    }
}

final class SelfSizingCollectionView: UICollectionView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
