//
//  UploadCancelView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 3/11/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class UploadCancelView: UIView {
    
    // MARK: - UI Components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .UmbbaBlack.withAlphaComponent(0.5)
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .White500
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let alertTitle: UILabel = {
        let label = UILabel()
        label.text = "작성을 취소하시겠어요?\n작성 중인 글은 저장되지 않아요"
        label.numberOfLines = 2
        label.font = .PretendardRegular(size: 16)
        label.textColor = .UmbbaBlack
        label.textAlignment = .center
        return label
    }()
    
    lazy var cancelButton: UIButton = {
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
    
    lazy var deleteButton: UIButton = {
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
        stackView.addArrangedSubviews(cancelButton, deleteButton)
        return stackView
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHiearchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension UploadCancelView {
    
    func setUI() {
        self.backgroundColor = .clear
    }
    
    func setHiearchy() {
        self.alertView.addSubviews(alertTitle, buttonStackView)
        self.addSubviews(backgroundView, alertView)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            let width = SizeLiterals.Screen.screenWidth * 343 / 375
            $0.center.equalToSuperview()
            $0.width.equalTo(width)
            $0.height.equalTo(width * 164 / 343)
        }
        
        alertTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        deleteButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        buttonStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(29)
            $0.leading.trailing.equalToSuperview().inset(32)
        }
    }
}
