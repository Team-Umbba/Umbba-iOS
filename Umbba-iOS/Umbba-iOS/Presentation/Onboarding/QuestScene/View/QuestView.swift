//
//  QuestView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/15.
//

import UIKit

import SnapKit

final class QuestView: UIView {
    
    // MARK: - Properties
    
    var section = 0
    weak var navigationdelegate: NavigationBarDelegate?
    weak var nextDelegate: NextButtonDelegate?
    
    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.isLeftButtonIncluded = true
        return view
    }()
    
    private let questTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "간단한 질문에\n대답해줘"
        label.textColor = .UmbbaBlack
        label.font = .PretendardRegular(size: 24)
        label.setLineSpacingPartFontChange(lineSpacing: 2, targetString: "간단한 질문", font: .PretendardSemiBold(size: 24))
        label.numberOfLines = 2
        return label
    }()
    
    private let questDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "해당 답변은 추후 제공될 질문을 구성하는 데 이용돼요"
        label.textColor = .Gray800
        label.font = .PretendardRegular(size: 12)
        return label
    }()
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .Gray400
        view.progressTintColor = .Primary600
        view.progress = 0.2
        return view
    }()
    
    lazy var questCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: SizeLiterals.Screen.screenWidth - 48, height: 349)
        layout.minimumLineSpacing = 48
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .UmbbaWhite
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    lazy var nextButton: CustomButton = {
        let button = CustomButton(status: false, title: I18N.Common.nextButtonTitle)
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setAddTarget()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension QuestView {
    func setUI() {
        self.backgroundColor = .UmbbaWhite
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        self.addSubviews(navigationBarView, questTitleLabel, questDescriptionLabel, progressView, questCollectionView, nextButton)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        questTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(24)
        }
        
        questDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(questTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(questTitleLabel.snp.leading)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(questDescriptionLabel.snp.bottom).offset(11)
            $0.trailing.leading.equalToSuperview().inset(24)
        }
        
        questCollectionView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(56)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(349)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-12)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    // MARK: - @objc Functions

    @objc
    func backButtonTapped() {
        navigationdelegate?.backButtonTapped()
    }
    
    @objc
    func nextButtonTapped() {
        nextDelegate?.nextButtonTapped()
    }
}
