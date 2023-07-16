//
//  AnswerDetailViewController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/13.
//

import UIKit

final class AnswerDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private var answerEntity: AnswerEntity? {
        didSet {
            fetchData()
        }
    }
    
    // MARK: - UI Components
    
    private let answerDetailView = AnswerDetailView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = answerDetailView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getAnswerAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAnswerAPI()
        setDelegate()
    }
}

// MARK: - Extensions

extension AnswerDetailViewController {
    func setDelegate() {
        answerDetailView.delegate = self
        answerDetailView.nextDelegate = self
    }
    
    func fetchData() {
        guard let answerEntity = answerEntity else { return }
        answerDetailView.setDataBind(model: answerEntity)
    }
}

extension AnswerDetailViewController: NavigationBarDelegate {
    func backButtonTapped() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first else {
            return
        }
        keyWindow.rootViewController = TabBarController()
    }

    func completeButtonTapped() {
        
    }
}

extension AnswerDetailViewController: NextButtonDelegate {
    func nextButtonTapped() {
        self.navigationController?.pushViewController(AnswerWriteViewController(), animated: true)
    }
}

// MARK: - Network

extension AnswerDetailViewController {
    func getAnswerAPI() {
        HomeService.shared.getAnswerAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<AnswerEntity> {
                    if let answerData = data.data {
                        dump(answerData)
                        self.answerEntity = answerData
                    }
                }
            default:
                break
            }
        }
    }
}
