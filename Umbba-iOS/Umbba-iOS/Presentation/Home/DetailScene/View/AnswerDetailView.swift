//
//  AnswerDetailView.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/13.
//

import UIKit

import SnapKit

final class AnswerDetailView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: NavigationBarDelegate?
    
    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.cafe24Title = I18N.Write.navigationTitle
        view.isTitleViewIncluded = true
        view.isLeftButtonIncluded = true
        return view
    }()

    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setAddTarget()
        setDelegate()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension AnswerDetailView {
    
    func setUI() {
        self.backgroundColor = .UmbbaWhite
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    func setDelegate() {
        
    }
    
    func setLayout() {
        self.addSubviews(navigationBarView)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    @objc
    func backButtonTapped() {
        delegate?.backButtonTapped()
    }
}
