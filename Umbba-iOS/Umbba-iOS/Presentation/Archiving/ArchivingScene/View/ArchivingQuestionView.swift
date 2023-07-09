//
//  ArchivingQuestionView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/09.
//

import UIKit

import SnapKit

final class ArchivingQuestionView: UIView {
    
    lazy var questionColletionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
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

private extension ArchivingQuestionView {
     func setUI() {
         backgroundColor = .UmbbaWhite
         
         flowLayout.minimumInteritemSpacing = 0
         flowLayout.scrollDirection = .vertical
         flowLayout.itemSize = CGSize(width: 400, height: 65)
     }

     func setHierarchy() {
         addSubview(questionColletionView)
     }

     func setLayout() {
         questionColletionView.snp.makeConstraints {
             $0.top.equalTo(safeAreaInsets)
             $0.leading.equalToSuperview()
             $0.height.equalTo(200)
         }
     }
 }
