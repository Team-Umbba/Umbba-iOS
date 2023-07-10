//
//  AnswerWriteViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/10.
//

import UIKit

final class AnswerWriteViewController: UIViewController {
    
    private let answerWriteView = AnswerWriteView()
    
    override func loadView() {
        super.loadView()
        
        view = answerWriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationUI()
        setDelegate()
    }
}

// MARK: - Extensions

extension AnswerWriteViewController {
    func setNavigationUI() {
        navigationController?.isNavigationBarHidden = true
    }
    
    func setDelegate() {
        answerWriteView.delegate = self
    }
}

extension AnswerWriteViewController: AnswrWriteDelegate {
    func backButtonTapped() {
        print("작성 취소 팝업")
    }
    
    func completeButtonTapped() {
        print("작성 저장 팝업")
    }
}
