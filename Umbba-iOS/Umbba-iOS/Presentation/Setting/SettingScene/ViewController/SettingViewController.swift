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
        
    private let settingTableView = SettingTableView()
    private lazy var settingtableView = settingTableView.tableView
    let userSection = Setting.section0()
    let teamSection = Setting.section1()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = settingTableView
        
        setDelegate()
    }
}

// MARK: - Extensions

private extension SettingViewController {

    func setDelegate() {
        settingtableView.delegate = self
        settingtableView.dataSource = self
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
            return userSection.count
        } else if section == 1 {
            return teamSection.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingTableViewCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
        
        if indexPath.section == 0 {
            cell.configureCell(userSection[indexPath.row])
        } else if indexPath.section == 1 {
            cell.configureCell(teamSection[indexPath.row])
        } else {
            return UITableViewCell()
        }
        return cell
    }
}
