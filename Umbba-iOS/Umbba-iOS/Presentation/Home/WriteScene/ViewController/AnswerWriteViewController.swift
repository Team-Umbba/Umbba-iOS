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
        setDelegate()
    }
}

// MARK: - Extensions

extension AnswerWriteViewController {
    func setDelegate() {
        answerWriteView.delegate = self
    }
}

extension AnswerWriteViewController: AnswrWriteDelegate {
    func backButtonTapped() {
        self.makeAlert(alertType: .withdrawalAlert) {
            print("이전 화면으로 이동")
        }
    }
    
    func completeButtonTapped() {
        self.makeAlert(alertType: .writeSaveAlert) {
            print("작성 저장 API")
        }
    }
}
