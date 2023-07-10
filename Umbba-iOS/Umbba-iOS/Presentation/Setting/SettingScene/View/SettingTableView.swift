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
    
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    let userSection = Setting.section0()
    let teamSection = Setting.section1()
    
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
        backgroundColor = .white
    }
    
    func setLayout() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setTableView() {
        tableView.backgroundColor = .white
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
