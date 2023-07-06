//
//  EntryView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/05.
//

import UIKit

import SnapKit

final class EntryView: UIView {
    
    private lazy var loginViewImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.loginTitle
        label.textColor = .UmbbaBlack
        label.font = .PretendardRegular(size: 24)
        return label
    }()
    
    lazy var entryButton: UIButton = {
        let button = CustomButton(status: true, title: I18N.Auth.entryButtonTitle)
        return button
    }()
    
    private lazy var dividingText: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.dividingText
        label.textColor = .lightGray
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private lazy var inviteText: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.inviteText
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    lazy var inviteButton: UIButton = {
        let button = CustomButton(status: false, title: I18N.Auth.inviteButtonTitle)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // MARK: - addsubView
        setHierarchy()
        
        // MARK: - autolayout설정
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EntryView {
    
    private func setHierarchy() {
        addSubviews(loginViewImage, loginLabel, entryButton, dividingText, inviteText, inviteButton)
    }
    
    private func setLayout() {
        backgroundColor = .white
        
        loginViewImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(85)
            $0.leading.equalToSuperview().inset(24)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 86 / 375)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 22 / 375)
        }
        
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(loginViewImage.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(24)
        }
        
        entryButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(178)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        
        dividingText.snp.makeConstraints {
            $0.top.equalTo(entryButton.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        inviteText.snp.makeConstraints {
            $0.top.equalTo(dividingText.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        inviteButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(44)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }

}
