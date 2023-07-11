//
//  AccountTableView.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/11.
//

import UIKit

import SnapKit

final class AccountTableView: UIView {
    
    // MARK: - UI Components
    
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

private extension AccountTableView {
    
    func setUI() {
        backgroundColor = .Gray400
    }
    
    func setLayout() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setTableView() {
        tableView.backgroundColor = .Gray400
    }
    
    func registerCell() {
        SettingTableViewCell.register(target: tableView)
    }
}

