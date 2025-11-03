//
//  LevelsCollectionView.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import UIKit

final class LevelsCollectionView: UIView {
    
    private let collectionView: UICollectionView
    
    private let columns = 3
    private let rows = 5
    private let spacing: CGFloat = 13
    private let pageSpacing: CGFloat = 26
    
    private var pageUpdateHandler: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        collectionView = LevelsCollectionView.createLayoutCollectionView(
            columns: 3,
            rows: 5,
            spacing: 13,
            pageSpacing: 26,
            pageUpdateHandler: nil
        )
        super.init(frame: frame)
        setupCollectionView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.register(LevelCell.self, forCellWithReuseIdentifier: LevelCell.identifier)
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setDataSource(_ dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) {
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.reloadData()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
        
    func configureLayoutWithPageUpdateHandler(_ handler: @escaping (Int) -> Void) {
        pageUpdateHandler = handler
        collectionView.setCollectionViewLayout(
            LevelsCollectionView.createLayout(
                columns: columns,
                rows: rows,
                spacing: spacing,
                pageSpacing: pageSpacing,
                pageUpdateHandler: handler
            ),
            animated: false
        )
    }
    
    private static func createLayout(
        columns: Int,
        rows: Int,
        spacing: CGFloat,
        pageSpacing: CGFloat,
        pageUpdateHandler: @escaping (Int) -> Void
    ) -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / CGFloat(columns)),
            heightDimension: .fractionalWidth(1.0 / CGFloat(columns))
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing / 2, bottom: spacing, trailing: spacing / 2)
        
        let rowGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: itemSize.heightDimension
            ),
            subitems: Array(repeating: item, count: columns)
        )
        
        let pageGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(CGFloat(rows) / CGFloat(columns))
            ),
            subitems: Array(repeating: rowGroup, count: rows)
        )
        
        let section = NSCollectionLayoutSection(group: pageGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = pageSpacing
        
        section.visibleItemsInvalidationHandler = { _, offset, _ in
            let page = Int(round(offset.x / UIScreen.main.bounds.width))
            pageUpdateHandler(page)
        }
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private static func createLayoutCollectionView(
        columns: Int,
        rows: Int,
        spacing: CGFloat,
        pageSpacing: CGFloat,
        pageUpdateHandler: ((Int) -> Void)?
    ) -> UICollectionView {
        let layout = createLayout(
            columns: columns,
            rows: rows,
            spacing: spacing,
            pageSpacing: pageSpacing,
            pageUpdateHandler: pageUpdateHandler ?? { _ in }
        )
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
}
