//
//  SettingViewController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/07.
//

import UIKit

import SnapKit

final class SettingViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let section0 = Setting.section0()
    private let section1 = Setting.section1()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setTableView()
        registerCell()
        setDelegate()
    }
}

// MARK: - Extensions

private extension SettingViewController {
    
    func setUI() {
        view.backgroundColor = .white
    }
    
    func setLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets)
            $0.leading.trailing.bottom.equalToSuperview()
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
    
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let header = SettingSectionHeaderView.dequeueReusableHeaderFooterView(tableView: tableView)
            return header
        } else {
            return UIView()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 72
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            let accountViewController = AccountViewController()
            self.navigationController?.pushViewController(accountViewController, animated: true)
        case 1:
            if indexPath.row == 0 { print("--> \(indexPath.row)") }
            if indexPath.row == 1 { print("--> \(indexPath.row)") }
            if indexPath.row == 2 { print("--> \(indexPath.row)") }
        default:
            return
        }
        
    }
}

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return section0.count
        } else if section == 1 {
            return section1.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingTableViewCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
        
        if indexPath.section == 0 {
            cell.configureCell(section0[indexPath.row])
        } else if indexPath.section == 1 {
            cell.configureCell(section1[indexPath.row])
        } else {
            return UITableViewCell()
        }
        return cell
    }
}
