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

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Setting.settingTitle
        label.font = .PretendardRegular(size: 20)
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let dummy = Setting.dummy()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setTableView()
        registerCell()
        setDelegate()
        setNavigationUI()
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
    }
    
    func registerCell() {
        SettingTableViewCell.register(target: tableView)
        SettingSectionHeaderView.register(target: tableView)
    }
    
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setNavigationUI() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.PretendardRegular(size: 20), .foregroundColor: UIColor.UmbbaBlack]
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
}

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SettingSectionHeaderView.dequeueReusableHeaderFooterView(tableView: tableView)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
}

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingTableViewCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
        cell.configureCell(dummy[indexPath.row])
        return cell
    }
}
