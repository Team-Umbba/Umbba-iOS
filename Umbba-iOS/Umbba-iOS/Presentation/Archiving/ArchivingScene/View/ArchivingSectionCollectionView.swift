//
//  ArchivingSectionCollectionView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/09/16.
//

import UIKit

import SnapKit

final class ArchivingSectionCollectionView: UIView {
    
    // MARK: - UI Components
    
    lazy var archivingSectionCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize.height = 26
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsSelection = true
        collectionView.backgroundColor = .White500
        return collectionView
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHiearchy()
        setLayout()
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension ArchivingSectionCollectionView {
    
    func setHiearchy() {
        self.addSubview(archivingSectionCollectionView)
    }

    func setLayout() {
        archivingSectionCollectionView.snp.makeConstraints {
            $0.centerY.equalToSuperview().inset(8)
        }
    }
    
    func registerCell() {
        ArchivingSectionCollectionViewCell.register(target: archivingSectionCollectionView)
    }
}
