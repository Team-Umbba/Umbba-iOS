//
//  RecordView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 1/27/24.
//

import UIKit

import SnapKit

final class RecordView: UIView {

    // MARK: - Properties
    
    weak var navigationdelegate: NavigationBarDelegate?
    
    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let navigation = CustomNavigationBar()
        navigation.isLeftButtonIncluded = true
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
    
    private lazy var recordButton = CustomButton(status: true, title: "사진 업로드하기")
    
    private let emptyImage = UIImageView(image: UIImage(resource: .recordEmpty))
    private let emptyTitle: UILabel = {
        let label = UILabel()
        label.text = "업로드 한 사진이 없어요"
        label.textColor = .Gray800
        label.font = .PretendardSemiBold(size: 16)
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setRegisterCell()
        setAddTarget()
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
        collectionView.isHidden = true
    }
    
    func setHierarchy() {
        self.addSubviews(navigationBarView, titleLabel, subTitleLabel, recordButton, collectionView, emptyImage, emptyTitle)
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
        
        recordButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(60)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(recordButton.snp.top)
        }
        
        emptyImage.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 120 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(165)
            $0.height.equalTo(158)
        }
        
        emptyTitle.snp.makeConstraints {
            $0.top.equalTo(emptyImage.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
    }

    func setRegisterCell() {
        RecordCollectionViewCell.register(target: collectionView)
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func backButtonTapped() {
        navigationdelegate?.backButtonTapped()
    }
}
