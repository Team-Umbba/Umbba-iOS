//
//  AssignViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/11.
//

import UIKit

import SafariServices

final class AssignViewController: UIViewController {
    
    private let assignView = AssignView()
    
    override func loadView() {
        super.loadView()
        
        self.view = assignView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
    }

}

// MARK: - Extensions

extension AssignViewController {
    func setDelegate() {
        assignView.assignDelegate = self
        assignView.nextDelegate = self
    }
}

extension AssignViewController: AssignDelegate {
    func presentURL(secton section: Int) {
        switch section {
        case 1:
            if let url = URL(string: I18N.Setting.urlArray[0]) {
                let safariViewController = SFSafariViewController(url: url)
                present(safariViewController, animated: true, completion: nil) }
        case 2:
            if let url = URL(string: I18N.Setting.urlArray[1]) {
                let safariViewController = SFSafariViewController(url: url)
                present(safariViewController, animated: true, completion: nil) }
        default:
            break
        }
    }
}

extension AssignViewController: NextButtonDelegate {
    func nextButtonTapped() {
        self.navigationController?.pushViewController(EntryViewController(), animated: false)
    }
}
