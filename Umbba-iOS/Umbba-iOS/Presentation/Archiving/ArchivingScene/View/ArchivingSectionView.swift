//
//  ArchivingSectionView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/09.
//

import UIKit

import SnapKit

final class ArchivingSectionView: UIView {
    
    lazy var archivingColletionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let flowLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // MARK: - UI Components
        setUI()
        
        // MARK: - addsubView
        setHierarchy()
        
        // MARK: - autolayout설정
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ArchivingSectionView {
     func setUI() {
         backgroundColor = .UmbbaWhite
         
         flowLayout.minimumInteritemSpacing = 12
         flowLayout.scrollDirection = .horizontal
     }

     func setHierarchy() {
         addSubview(archivingColletionView)
     }

     func setLayout() {
         archivingColletionView.snp.makeConstraints {
             $0.top.equalTo(safeAreaInsets)
             $0.leading.trailing.equalToSuperview().inset(12)
             $0.height.equalTo(150)
         }
     }
 }
