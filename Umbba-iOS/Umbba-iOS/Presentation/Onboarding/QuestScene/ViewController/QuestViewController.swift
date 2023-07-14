//
//  QuestViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/15.
//

import UIKit

final class QuestViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let questView = QuestView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = questView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
    }
}

// MARK: - Extensions

private extension QuestViewController {

    func setDelegate() {
        questView.navigationdelegate = self
        questView.nextDelegate = self
    }
}

extension QuestViewController: NavigationBarDelegate {
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {

    }
}

extension QuestViewController: NextButtonDelegate {
    func nextButtonTapped() {
//        self.navigationController?.pushViewController(), animated: true)
    }
}
