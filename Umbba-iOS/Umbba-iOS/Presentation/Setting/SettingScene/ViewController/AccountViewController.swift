//
//  AccountViewController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/11.
//

import UIKit

final class AccountViewController: UIViewController {

    // MARK: - UI Components
    
    private let accountTableView = AccountTableView()
    private lazy var accounttableView = accountTableView.tableView
    private let accountSection = I18N.Setting.accountSectionLabel
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        view = accountTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
    }
}

// MARK: - Extensions

private extension AccountViewController {
    
    func setDelegate() {
        accounttableView.delegate = self
        accounttableView.dataSource = self
    }
}

extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingTableViewCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
        cell.contentLabel.text = I18N.Setting.accountSectionLabel[indexPath.row]
        cell.buttonImage.isHidden = true
        return cell
    }
}
