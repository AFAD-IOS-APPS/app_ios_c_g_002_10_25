//
//  LevelsView.swift
//  Bomb Maze
//
//  Created by Mark Kurlovich on 22/10/2025.
//

import UIKit

protocol LevelsViewDelegate: AnyObject {
    func didChooseLevel(level: Level)
}

final class LevelsView: GradientView {
    
    weak var delegate: LevelsViewDelegate?
    
    private var levels: [Level] = []
    
    private let pageControl = UIPageControl()
    private var levelsCollectionView: LevelsCollectionView!
    
    private let columns = 3
    private let rows = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 51
        layer.masksToBounds = true
        
        levelsCollectionView = LevelsCollectionView()
        levelsCollectionView.configureLayoutWithPageUpdateHandler { [weak self] page in
            self?.pageControl.currentPage = page
        }
        
        levelsCollectionView.setDataSource(self, delegate: self)
        
        configureGradient(
            colors: [
                Colors.blueGradientFirstColor.color,
                Colors.blueGradientSecondColor.color
            ]
        )
        
        addSubview(levelsCollectionView)
        levelsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.5)
        pageControl.currentPageIndicatorTintColor = .white
        
        NSLayoutConstraint.activate([
            levelsCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            levelsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            levelsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            pageControl.topAnchor.constraint(equalTo: levelsCollectionView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    func configureLevels(levels: [Level]) {
        self.levels = levels
        levelsCollectionView.reloadData()
        
        let itemsPerPage = columns * rows
        let pages = Int(ceil(Double(levels.count) / Double(itemsPerPage)))
        pageControl.numberOfPages = max(pages, 1)
        pageControl.currentPage = 0
    }
}

extension LevelsView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        levels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelCell.identifier, for: indexPath) as! LevelCell
        cell.configure(
            with: levels[indexPath.item],
            at: indexPath.item
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didChooseLevel(level: levels[indexPath.item])
    }
}
