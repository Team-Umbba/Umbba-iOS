//
//  SettingViewController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/07.
//

import UIKit

import SnapKit

class SettingViewController: UIViewController {
    
    // MARK: - UI Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.Setting.settingTitle
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
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.rowHeight = 72
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
        let sectionHeaderView = SettingSectionHeaderView()
        return sectionHeaderView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 72
    }
}

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }

        cell.configureCell(dummy[indexPath.row])
        
        return cell
    }
}
