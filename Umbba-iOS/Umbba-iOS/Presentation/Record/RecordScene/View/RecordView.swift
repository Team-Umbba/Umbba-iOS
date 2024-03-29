//
//  RecordView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 1/27/24.
//

import UIKit

import SnapKit

enum RecordViewStatus {
    case emptyRecord
    case hasRecord
}

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
        label.text = I18N.Record.recordTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardSemiBold(size: 24)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Record.recordSubTitle
        label.textColor = .Gray900
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    lazy var recordCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: SizeLiterals.Screen.screenWidth - 48, height: SizeLiterals.Screen.screenWidth - 48)
        layout.minimumInteritemSpacing = 16
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .White400
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        return collectionView
    }()
    
    lazy var recordButton = CustomButton(status: true, title: I18N.Record.recordButtonTitle)
    
    private let emptyImage = UIImageView(image: UIImage(resource: .recordEmpty))
    private let emptyTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Record.recordEmptyTitle
        label.textColor = .Gray800
        label.font = .PretendardSemiBold(size: 16)
        return label
    }()
    
    private lazy var bottomLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.White500.withAlphaComponent(0).cgColor,
                           UIColor.White500.withAlphaComponent(0.6).cgColor,
                           UIColor.White500.withAlphaComponent(1).cgColor]
        return gradient
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bottomLayer.frame = CGRect(x: 0,
                                   y: SizeLiterals.Screen.screenHeight - SizeLiterals.Screen.screenHeight * 84 / 812 - self.safeAreaInsets.bottom / 2,
                                   width: SizeLiterals.Screen.screenWidth,
                                   height: SizeLiterals.Screen.screenHeight * 84 / 812)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension RecordView {

    func setUI() {
        backgroundColor = .White500
        emptyImage.isHidden = true
        emptyTitle.isHidden = true
    }
    
    func setHierarchy() {
        self.addSubviews(navigationBarView, titleLabel, subTitleLabel, recordCollectionView, emptyImage, emptyTitle)
        self.layer.addSublayer(bottomLayer)
        self.addSubview(recordButton)
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
        
        recordCollectionView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        recordButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(60)
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
        RecordCollectionViewCell.register(target: recordCollectionView)
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func backButtonTapped() {
        navigationdelegate?.backButtonTapped()
    }
}

extension RecordView {
    
    func configureView(_ status: RecordViewStatus) {
        switch status {
        case .emptyRecord:
            emptyImage.isHidden = false
            emptyTitle.isHidden = false
            recordCollectionView.isHidden = true
        case .hasRecord:
            emptyImage.isHidden = true
            emptyTitle.isHidden = true
            recordCollectionView.isHidden = false
        }
    }
}
