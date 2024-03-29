//
//  UpdateAlertView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 10/2/23.
//

import UIKit

import SnapKit

final class UpdateAlertView: UIView {
    
    weak var delegate: AlertDelegate?
    
    // MARK: - UI Components
    
    private let updateTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Alert.updateTitle
        label.font = .PretendardSemiBold(size: 20)
        label.textColor = .UmbbaBlack
        return label
    }()
    
    private let updateSubtitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Alert.updateSubtitle
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .PretendardRegular(size: 16)
        label.textColor = .UmbbaBlack
        return label
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .Primary500
        button.setTitleColor(.White500, for: .normal)
        button.setTitle(I18N.Alert.updateButtonTitle, for: .normal)
        button.titleLabel?.font = .PretendardSemiBold(size: 16)
        button.layer.cornerRadius = 24
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

private extension UpdateAlertView {
    func setUI() {
        self.backgroundColor = .White500
        self.layer.cornerRadius = 16
    }
    
    func setAddTarget() {
        updateButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        self.addSubviews(updateTitle, updateSubtitle, updateButton)
        
        updateTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.height.equalTo(24)
            $0.centerX.equalToSuperview()
        }
        
        updateSubtitle.snp.makeConstraints {
            $0.top.equalTo(updateTitle.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        updateButton.snp.makeConstraints {
            $0.top.equalTo(updateSubtitle.snp.bottom).offset(32)
            $0.height.equalTo(48)
            $0.bottom.equalToSuperview().inset(32)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 268 / 375)
        }
    }
    
    @objc func shareButtonTapped() {
        delegate?.colorButtonTapped()
    }
}
