//
//  SettingTableView.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/11.
//

import UIKit

import SnapKit

final class SettingTableView: UIView {
    
    // MARK: - UI Components
    
    private let navigationBarView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.pretendardTitle = I18N.Setting.settingNavigationTitle
        return view
    }()
    
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
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
        backgroundColor = .UmbbaWhite
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
        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderTopPadding = 1
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = true
    }
    
    func registerCell() {
        SettingTableViewCell.register(target: tableView)
        SettingSectionHeaderView.register(target: tableView)
    }
}
