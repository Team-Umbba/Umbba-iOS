//
//  EntryView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/05.
//

import UIKit

import SnapKit

final class EntryView: UIView {
    
    // MARK: - Properties
    weak var nextDelegate: NextButtonDelegate?
    
    // MARK: - UI Components
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.Common.img_umbbaLogo
        return image
    }()
    
    private let logoTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.logoTitle
        label.font = .Cafe24Regular(size: 20)
        label.textColor = .Primary500
        return label
    }()
    
    private let logoSubTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.logoSubTitle
        label.font = .PretendardRegular(size: 12)
        label.textColor = .Primary500
        return label
    }()
    
    lazy var entryButton: UIButton = {
        let button = CustomButton(status: true, title: I18N.Auth.entryButtonTitle)
        return button
    }()
    
    private let dividingText: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.dividingText
        label.textColor = .Gray800
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private let inviteText: UILabel = {
        let label = UILabel()
        label.text = I18N.Auth.inviteText
        label.textColor = .Gray800
        label.font = .PretendardRegular(size: 16)
        return label
    }()
    
    private lazy var inviteButton: UIButton = {
        let button = CustomButton(status: true, title: I18N.Auth.inviteButtonTitle)
        button.setBackgroundColor(.UmbbaWhite, for: .normal)
        button.setTitleColor(.Primary500, for: .normal)
        button.layer.borderColor = UIColor.Primary500.cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EntryView {
    private func setUI() {
        backgroundColor = .UmbbaWhite
    }
    
    private func setHierarchy() {
        addSubviews(logoImage, logoTitle, logoSubTitle, entryButton, dividingText, inviteText, inviteButton)
    }
    
    private func setLayout() {
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(97)
            $0.width.equalTo(67)
            $0.height.equalTo(60)
        }
        
        logoTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImage.snp.bottom).offset(2)
        }
        
        logoSubTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoTitle.snp.bottom).offset(12)
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

    private func setAddTarget() {
        entryButton.addTarget(self, action: #selector(entryButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func entryButtonTapped() {
        nextDelegate?.nextButtonTapped()
    }
}
