//
//  CancelView.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/13.
//

import UIKit

import SnapKit

protocol WithdrawlDelegate: AnyObject {
    func withdrawlButtonTapped()
}

class WithdrawalView: UIView {
    
    // MARK: - Properties
    
    weak var navigationdelegate: NavigationBarDelegate?
    weak var withdrawldelegate: WithdrawlDelegate?

    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.pretendardTitle = I18N.Setting.cancelNavigatonTitle
        view.isLeftButtonIncluded = true
        return view
    }()
    
    private let quoteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.Gray400.cgColor
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let quoteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Primary600
        label.text = I18N.Setting.quoteLabel
        label.font = .PretendardSemiBold(size: 20)
        return label
    }()
    
    private let personLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Primary600
        label.text = I18N.Setting.personLabel
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private let withdrawalQuestLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.text = I18N.Setting.withdrawalQuestLabel
        label.font = .PretendardSemiBold(size: 20)
        return label
    }()
    
    private let withdrawalContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.text = I18N.Setting.withdrawalContentLabel
        label.font = .PretendardRegular(size: 12)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var withdrawalButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.Setting.withdrawalButton, for: .normal)
        button.titleLabel?.font = .PretendardSemiBold(size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 30
        button.backgroundColor = .Error
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

private extension WithdrawalView {
    
    func setUI() {
        backgroundColor = .UmbbaWhite
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        withdrawalButton.addTarget(self, action: #selector(withdrawlButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        addSubviews(navigationBarView, quoteView, withdrawalQuestLabel, withdrawalContentLabel, withdrawalButton)
        quoteView.addSubviews(quoteLabel, personLabel)
        
        navigationBarView.snp.makeConstraints {
             $0.top.equalTo(self.safeAreaLayoutGuide)
             $0.leading.trailing.equalToSuperview()
        }
        
        quoteView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(58)
            $0.height.equalTo(120)
        }
        
        quoteLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.centerX.equalToSuperview()
        }
        
        personLabel.snp.makeConstraints {
            $0.top.equalTo(quoteLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        withdrawalQuestLabel.snp.makeConstraints {
            $0.top.equalTo(quoteView.snp.bottom).offset(29)
            $0.leading.equalToSuperview().inset(24)
        }
        
        withdrawalContentLabel.snp.makeConstraints {
            $0.top.equalTo(withdrawalQuestLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        withdrawalButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(safeAreaInsets.bottom + 12)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(60)
        }
    }
    
    @objc
    func backButtonTapped() {
        navigationdelegate?.backButtonTapped()
    }
    
    @objc
    func withdrawlButtonTapped() {
        withdrawldelegate?.withdrawlButtonTapped()
    }
}
