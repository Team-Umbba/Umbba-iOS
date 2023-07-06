//
//  UserInfoViewController.swift
//  Umbba-Lab
//
//  Created by 최영린 on 2023/07/06.
//

import UIKit

final class UserInfoViewController: UIViewController {
    
    private let userInfoView = UserInfoView()
    private lazy var nextButton = userInfoView.nextButton
    
    override func loadView() {
        super.loadView()
        
        view = userInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationUI()
    }
}

// MARK: - Methods

extension UserInfoViewController {
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
