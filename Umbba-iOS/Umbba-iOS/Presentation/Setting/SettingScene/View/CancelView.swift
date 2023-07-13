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
        addSubviews(navigationBarView, quoteView)
        
        navigationBarView.snp.makeConstraints {
             $0.top.equalTo(self.safeAreaLayoutGuide)
             $0.leading.trailing.equalToSuperview()
        }
        
        quoteView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(58)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 120 / 812)
        }
    }
    
    @objc
    func backButtonTapped() {
        navigationdelegate?.backButtonTapped()
    }
}
