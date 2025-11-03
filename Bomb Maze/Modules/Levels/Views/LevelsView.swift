//
//  LevelsView.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import UIKit

protocol LevelsViewDelegate: AnyObject {
    func didChooseLevel(index: Int)
}

final class LevelsView: GradientView {
    
    weak var delegate: LevelsViewDelegate?
    
    private var levelsCount: Int = 0
    
    private let pageControl = PageControl()
    private var levelsCollectionView = LevelsCollectionView()
    
    private let columns = 3
    private let rows = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.cornerRadius = 51
        layer.masksToBounds = true
        
        levelsCollectionView.configureLayoutWithPageUpdateHandler { [weak self] page in
            self?.pageControl.currentPage = page
        }
        
        levelsCollectionView.setDataSource(self, delegate: self)
        
        configureGradient(
            colors: [
                .blueGradientFirst,
                .blueGradientSecond
            ]
        )
        
        addView(levelsCollectionView)
        
        addView(pageControl)
        pageControl.currentPage = 0
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            levelsCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            levelsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            levelsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            pageControl.topAnchor.constraint(equalTo: levelsCollectionView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    func reloadCollectionView() {
        levelsCollectionView.reloadData()
    }
    
    func configure(levelsCount: Int) {
        self.levelsCount = levelsCount
        levelsCollectionView.reloadData()
        
        let itemsPerPage = columns * rows
        let pages = Int(ceil(Double(levelsCount) / Double(itemsPerPage)))
        pageControl.numberOfPages = max(pages, 1)
        pageControl.currentPage = 0
    }
}

extension LevelsView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        levelsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelCell.identifier, for: indexPath) as! LevelCell
        let progress = UserDefaultsManager.shared.progress
        
        if indexPath.item <= progress {
            cell.configure(with: indexPath.item)
        } else {
            cell.configureEmpty()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didChooseLevel(index: indexPath.item)
    }
}
