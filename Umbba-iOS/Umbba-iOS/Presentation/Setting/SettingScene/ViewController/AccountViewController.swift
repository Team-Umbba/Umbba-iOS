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
        accountTableView.navigationdelegate = self
    }
}

extension AccountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            patchLogOutAPI()
            return
        case 1:
            let withdrawlViewController = WithdrawalViewController()
            self.navigationController?.pushViewController(withdrawlViewController, animated: true)
        default:
            return
        }
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

extension AccountViewController: NavigationBarDelegate {
    
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
    }
    
}

// MARK: - Network
private extension AccountViewController {
    func patchLogOutAPI() {
        AuthService.shared.patchLogOutAPI { NetworkResult in
            switch NetworkResult {
            case .success:
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let keyWindow = windowScene.windows.first else {
                    return
                }
                UserManager.shared.clearAll()
                keyWindow.rootViewController = UINavigationController(rootViewController: LottieViewController())
                if let navigationController = keyWindow.rootViewController as? UINavigationController {
                    navigationController.isNavigationBarHidden = true
                }
            case .requestErr, .serverErr:
                self.makeAlert(title: "오류가 발생했습니다", message: "다시 시도해주세요")
            default:
                break
            }
        }
    }
}
