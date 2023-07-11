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
    private let userSection = I18N.Setting.userSectionLabel
    private let teamSection = I18N.Setting.teamSectionLabel

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
        switch section {
        case 0:
            return 0
        case 1:
            return 72
        default:
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
        switch section {
        case 0:
            return userSection.count
        case 1:
            return teamSection.count
        default:
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingTableViewCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.contentLabel.text = I18N.Setting.userSectionLabel[indexPath.row]
        case 1:
            cell.contentLabel.text = I18N.Setting.teamSectionLabel[indexPath.row]
        default:
            return UITableViewCell()
            
        }
        
        return cell
    }
}
