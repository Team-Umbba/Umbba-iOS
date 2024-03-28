//
//  QuizViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 1/31/24.
//

import UIKit

final class QuizViewController: UIViewController {

    // MARK: - Properties
    
    var quizEntity: QuizEntity? {
        didSet {
            fetchQuizData()
        }
    }
    
    // MARK: - UI Components
    
    private let quizView = QuizView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = quizView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
    }
    
}

// MARK: - Extensions

private extension QuizViewController {

    func setDelegate() {
        quizView.navigationdelegate = self
        quizView.nextDelegate = self
    }
    
    func fetchQuizData() {
        guard let quizEntity = quizEntity else { return }
        quizView.setDataBind(model: quizEntity)
    }
    
}

// MARK: - Network

extension QuizViewController {
    func patchQuizAnswerAPI(answer: Int) {
        QuizService.shared.patchQuizAnswerAPI(answer: answer) { networkResult in
            switch networkResult {
            case .success:
                self.navigationController?.pushViewController(ResultViewController(), animated: true)
            case .requestErr, .serverErr:
                self.makeAlert(title: "오류가 발생했습니다", message: "다시 시도해주세요")
            default:
                break
            }
        }
    }
}

extension QuizViewController: NavigationBarDelegate {
    @objc
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
        
    }
}

extension QuizViewController: NextButtonDelegate {
    func nextButtonTapped() {
        let answer = quizView.answer
        patchQuizAnswerAPI(answer: answer)
    }
}
