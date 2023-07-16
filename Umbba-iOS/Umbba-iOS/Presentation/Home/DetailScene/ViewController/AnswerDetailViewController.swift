//
//  AnswerDetailViewController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/13.
//

import UIKit

final class AnswerDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private var todayEntity: TodayEntity? {
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
        
        getTodayAPI()
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
        guard let todayEntity = todayEntity else { return }
        answerDetailView.setDataBind(model: todayEntity)
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
    func getTodayAPI() {
        HomeService.shared.getTodayAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<TodayEntity> {
                    if let todayData = data.data {
                        self.todayEntity = todayData
                    }
                }
            default:
                break
            }
        }
    }
}
