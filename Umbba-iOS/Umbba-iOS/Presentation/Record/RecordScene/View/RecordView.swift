//
//  RecordView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 1/27/24.
//

import UIKit

import SnapKit

final class RecordView: UIView {

    // MARK: - UI Components
    
    let navigationBarView: CustomNavigationBar = {
        let navigation = CustomNavigationBar()
        navigation.isLeftButtonIncluded = true
        navigation.isCameraButtonIncluded = true
        return navigation
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "사진으로 추억을 기록해요"
        label.textColor = .UmbbaBlack
        label.font = .PretendardSemiBold(size: 24)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "간단한 설명과 함께 사진을 업로드 하세요"
        label.textColor = .Gray900
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: SizeLiterals.Screen.screenWidth - 48, height: 160)
        layout.minimumInteritemSpacing = 16
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .White400
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        return collectionView
    }()
    
    private let uploadButton: UIButton = {
        let button = CustomButton(status: true, title: "사진 업로드하기")
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setRegisterCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension RecordView {

    func setUI() {
        backgroundColor = .White500
    }
    
    func setHierarchy() {
        self.addSubviews(navigationBarView, titleLabel, subTitleLabel, uploadButton, collectionView)
    }
    
    func setLayout() {
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(24)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        uploadButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(60)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(uploadButton.snp.top)
        }
    }

    func setRegisterCell() {
        RecordCollectionViewCell.register(target: collectionView)
    }
}
