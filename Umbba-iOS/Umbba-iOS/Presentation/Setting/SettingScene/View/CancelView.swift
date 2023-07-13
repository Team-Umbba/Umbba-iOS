//
//  CancelView.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/13.
//

import UIKit

import SnapKit

class CancelView: UIView {
    
    // MARK: - Properties
    
    weak var navigationdelegate: NavigationBarDelegate?

    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.pretendardTitle = I18N.Setting.cancelNavigatonTitle
        view.isLeftButtonIncluded = true
        return view
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

private extension CancelView {
    
    func setUI() {
        backgroundColor = .UmbbaWhite
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    func setLayout() {
        addSubviews(navigationBarView)
        
        navigationBarView.snp.makeConstraints {
             $0.top.equalTo(self.safeAreaLayoutGuide)
             $0.leading.trailing.equalToSuperview()
        }
    }
    
    @objc
    func backButtonTapped() {
        navigationdelegate?.backButtonTapped()
    }
}
