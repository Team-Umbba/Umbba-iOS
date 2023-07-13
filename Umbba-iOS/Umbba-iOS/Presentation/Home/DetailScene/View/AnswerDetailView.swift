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
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.text = I18N.Write.numberTitle
        label.font = .Cafe24Regular(size: 19)
        return label
    }()
    
    private let themeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .UmbbaBlack
        label.text = I18N.Write.themeTitle
        label.font = .Cafe24Regular(size: 20)
        return label
    }()
    
    private lazy var themeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.addArrangedSubviews(numberLabel, themeLabel)
        return stackView
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
        self.addSubviews(navigationBarView, themeStackView)
        
        navigationBarView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        themeStackView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom).offset(9)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc
    func backButtonTapped() {
        delegate?.backButtonTapped()
    }
}
