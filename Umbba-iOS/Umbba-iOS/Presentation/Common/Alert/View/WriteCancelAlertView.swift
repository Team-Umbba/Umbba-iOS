//
//  WriteCancelView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/11.
//

import UIKit

import SnapKit

// MARK: - Protocols

protocol AlertDelegate: AnyObject {
    func copyButtonTapped(inviteCode: String)
    func colorButtonTapped()
    func alertDismissTapped()
}

final class WriteCancelAlertView: UIView {
    
    weak var delegate: AlertDelegate?
    
    // MARK: - UI Components
    
    private let alertTitle: UILabel = {
        let label = UILabel()
        label.text = I18N.Alert.writeCancelTitle
        label.font = .PretendardRegular(size: 16)
        label.textColor = .UmbbaBlack
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .White500
        button.setTitleColor(.UmbbaBlack, for: .normal)
        button.setTitle(I18N.Alert.cancelButtonTitle, for: .normal)
        button.titleLabel?.font = .PretendardRegular(size: 16)
        button.layer.borderColor = UIColor.Gray400.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24
        return button
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .Primary500
        button.setTitleColor(.White500, for: .normal)
        button.setTitle(I18N.Alert.confirmButtonTitle, for: .normal)
        button.titleLabel?.font = .PretendardRegular(size: 16)
        button.layer.cornerRadius = 24
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 13
        stackView.addArrangedSubviews(cancelButton, confirmButton)
        return stackView
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

private extension WriteCancelAlertView {
    func setUI() {
        self.backgroundColor = .White500
        self.layer.cornerRadius = 16
    }
    
    func setAddTarget() {
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        self.addSubviews(alertTitle, buttonStackView)
        
        alertTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        confirmButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        buttonStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(29)
            $0.leading.trailing.equalToSuperview().inset(32)
        }
    }
    
    // MARK: - @objc Functions
    
    @objc func cancelButtonTapped() {
        delegate?.alertDismissTapped()
    }
    
    @objc func confirmButtonTapped() {
        delegate?.colorButtonTapped()
    }
}
