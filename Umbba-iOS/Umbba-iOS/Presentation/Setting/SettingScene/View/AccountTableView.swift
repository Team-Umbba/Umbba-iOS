//
//  AccountTableView.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/11.
//

import UIKit

import SnapKit

final class AccountTableView: UIView {
    
    // MARK: - Properties

    weak var navigationdelegate: NavigationBarDelegate?
    
    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.pretendardTitle = I18N.Setting.accountNavigationTitle
        view.isLeftButtonIncluded = true
        return view
    }()
    
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setAddTarget()
        setLayout()
        setTableView()
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension AccountTableView {
    
    func setUI() {
        backgroundColor = .UmbbaWhite
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    func setLayout() {
        addSubviews(navigationBarView, tableView)
        
        navigationBarView.snp.makeConstraints {
             $0.top.equalTo(self.safeAreaLayoutGuide)
             $0.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(navigationBarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setTableView() {
        tableView.backgroundColor = .UmbbaWhite
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
    }
    
    func registerCell() {
        SettingTableViewCell.register(target: tableView)
    }
    
    @objc
    func backButtonTapped() {
        navigationdelegate?.backButtonTapped()
    }
}
