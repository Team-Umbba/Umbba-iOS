//
//  MyPageView.swift
//  Umbba-iOS
//
//  Created by 최영린 on 1/30/24.
//

import UIKit

import SnapKit

// MARK: - Protocols

protocol SettingButtonDelegate: AnyObject {
    func settingButtonTapped()
}

final class MyPageView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: SettingButtonDelegate?

    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.isSettingButtonIncluded = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension MyPageView {
    func setUI() {
        self.backgroundColor = .White500
    }
    
    func setAddTarget() {
        navigationBarView.settingButton.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        self.addSubviews(navigationBarView)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    @objc
    func settingButtonTapped() {
        delegate?.settingButtonTapped()
    }
    
}
