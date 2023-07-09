//
//  FamiltInfoViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/09.
//

import UIKit

final class FamilyInfoViewController: UIViewController {
    
    private let familyInfoView = FamilyInfoView()
    private lazy var nextButton = familyInfoView.nextButton
    
    override func loadView() {
        super.loadView()
        
        view = familyInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationUI()
    }
}

// MARK: - Methods

extension FamilyInfoViewController {
    func setNavigationUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc
    func backButtonTapped() {
        print("이전 화면으로 이동")
        self.navigationController?.popViewController(animated: true)
    }
}
