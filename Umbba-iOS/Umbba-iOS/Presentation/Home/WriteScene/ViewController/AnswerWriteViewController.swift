//
//  AnswerWriteViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/10.
//

import UIKit

final class AnswerWriteViewController: UIViewController {
    
    // MARK: - Properties
    
    private var answerWrite: AnswerWrite = AnswerWrite()

    // MARK: - UI Components
    
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
        answerWriteView.answerWriteDelegate = self
        answerWriteView.navigationDelegate = self
    }
}

extension AnswerWriteViewController: NavigationBarDelegate, AnswerWriteDelegate {
    func answerDataBind(answerWrite: AnswerWrite) {
        self.answerWrite = answerWrite
    }
    
    func backButtonTapped() {
        self.makeAlert(alertType: .writeCancelAlert) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func completeButtonTapped() {
        self.makeAlert(answerWrite: self.answerWrite, alertType: .writeSaveAlert) {
            print("작성 저장 API")
        }
    }
}
