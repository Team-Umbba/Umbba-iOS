//
//  SettingTableView.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/11.
//

import UIKit

import SnapKit

final class SettingTableView: UIView {
    
    // MARK: - Properties

    weak var navigationdelegate: NavigationBarDelegate?
    
    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.pretendardTitle = I18N.Setting.settingNavigationTitle
        view.isLeftButtonIncluded = true
        return view
    }()
    
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        setAddTarget()
        setTableView()
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension SettingTableView {
    
    func setUI() {
        backgroundColor = .White500
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
        tableView.backgroundColor = .White500
        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderTopPadding = 1
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .none
    }
    
    func registerCell() {
        SettingTableViewCell.register(target: tableView)
        SettingSectionHeaderView.register(target: tableView)
    }
    
    func setAddTarget() {
        navigationBarView.leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func backButtonTapped() {
        navigationdelegate?.backButtonTapped()
    }
}
