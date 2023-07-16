//
//  AnswerWriteViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/10.
//

import UIKit

final class AnswerWriteViewController: UIViewController {
    
    // MARK: - Properties
    
    private var writePopUp: WritePopUp = WritePopUp()
    
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
    func answerDataBind(writePopUp: WritePopUp) {
        self.writePopUp = writePopUp
    }
    
    func backButtonTapped() {
        self.makeAlert(alertType: .writeCancelAlert) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func completeButtonTapped() {
        if writePopUp.answer == I18N.Write.answerPlaceholder || writePopUp.answer == "" {
            self.showToast(message: "답변을 입력해주세요")
        } else {
            self.makeAlert(writePopUp: writePopUp, alertType: .writeSaveAlert) {
                guard let answer = self.writePopUp.answer else { return }
                self.postAnswerAPI(answer: answer)
            }
        }
    }
}

private extension AnswerWriteViewController {
    func postAnswerAPI(answer: String) {
        HomeService.shared.postAnswerAPI(answer: answer) { NetworkResult in
            switch NetworkResult {
            case .success:
                self.navigationController?.popViewController(animated: true)
            case .requestErr, .serverErr:
                print("에러 발생")
            default:
                break
            }
            
        }
    }
}
