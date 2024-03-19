//
//  ResultViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 3/2/24.
//

import UIKit

final class ResultViewController: UIViewController {

    // MARK: - Properties
    
    var quizEntity: QuizEntity? {
        didSet {
            fetchQuizData()
        }
    }
    
    // MARK: - UI Components
    
    private let resultView = ResultView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getQuizAPI()
        setDelegate()
    }
    
}

// MARK: - Extensions

private extension ResultViewController {
    func setDelegate() {
        resultView.navigationdelegate = self
        resultView.nextDelegate = self
    }
    
    func fetchQuizData() {
        guard let quizEntity = quizEntity else { return }
        resultView.setDataBind(model: quizEntity)
    }
}

// MARK: - Network

extension ResultViewController {
    func getQuizAPI() {
        QuizService.shared.getQuizAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<QuizEntity> {
                    if let quizData = data.data {
                        self.quizEntity = quizData
                    }
                }
            case .requestErr, .serverErr:
                self.makeAlert(title: "오류가 발생했습니다", message: "다시 시도해주세요")
            default:
                break
            }
        }
    }
    
    func patchQuizNextAPI() {
        QuizService.shared.patchQuizNextAPI { networkResult in
            switch networkResult {
            case .success:
                self.navigationController?.popViewController(animated: true)
            case .requestErr, .serverErr:
                self.makeAlert(title: "오류가 발생했습니다", message: "다시 시도해주세요")
            default:
                break
            }
        }
    }
}

extension ResultViewController: NavigationBarDelegate {
    @objc
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
        
    }
}

extension ResultViewController: NextButtonDelegate {
    func nextButtonTapped() {
        patchQuizNextAPI()
    }
}
