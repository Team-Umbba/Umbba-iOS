//
//  FamiltInfoViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/09.
//

import UIKit

final class FamilyInfoViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let familyInfoView = FamilyInfoView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = familyInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
    }
}

// MARK: - Extensions

extension FamilyInfoViewController {
    func setDelegate() {
        familyInfoView.navigationdelegate = self
        familyInfoView.nextDelegate = self
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

extension FamilyInfoViewController: NavigationBarDelegate {
    @objc
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
        
    }
}

extension FamilyInfoViewController: NextButtonDelegate {
    func nextButtonTapped() {
        // FixMe: - 단답화면으로 이동해야함
        self.navigationController?.pushViewController(QuestViewController(), animated: true)
    }
}

extension FamilyInfoViewController: UIGestureRecognizerDelegate {
    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        view.addGestureRecognizer(tapGesture)
    }
}
