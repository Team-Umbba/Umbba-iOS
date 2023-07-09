//
//  CompleteViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/09.
//

import UIKit

final class CompleteViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let completeView = CompleteView()
    private lazy var nextButton = completeView.nextButton
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = completeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationUI()
        setAddTarget()
    }
}

// MARK: - Extensions

extension CompleteViewController {
    func setNavigationUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    func setAddTarget() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    @objc
    func nextButtonTapped() {
        print("다음 화면으로 이동")
    }
    
    @objc
    func backButtonTapped() {
        print("이전 화면으로 이동")
        self.navigationController?.popViewController(animated: true)
    }
}
