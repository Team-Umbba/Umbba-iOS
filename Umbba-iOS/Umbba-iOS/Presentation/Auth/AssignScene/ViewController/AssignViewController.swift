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
    }
}

extension AssignViewController: AssignDelegate {
    func presentURL(secton section: Int) {
        switch section {
        case 1:
            if let url = URL(string: "https://www.notion.so/f1a14bf60ed4421f9b3761ef88906adb") {
                let safariViewController = SFSafariViewController(url: url)
                present(safariViewController, animated: true, completion: nil) }
        case 2:
            if let url = URL(string: "https://www.notion.so/99fe0f58825d4f87bd3b987fadc623b6") {
                let safariViewController = SFSafariViewController(url: url)
                present(safariViewController, animated: true, completion: nil) }
        default:
            break
        }
    }
}
