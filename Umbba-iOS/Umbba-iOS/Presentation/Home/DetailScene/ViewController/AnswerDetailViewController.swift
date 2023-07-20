//
//  AnswerDetailViewController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/13.
//

import UIKit

final class AnswerDetailViewController: UIViewController {
    
    // MARK: - Properties
    // home으로 가야하면 true, list로 가야하면 false
    
    var isHome: Bool = true
    
    private var todayEntity: TodayEntity? {
        didSet {
            fetchTodayData()
        }
    }
    
    private var detailEntity: DetailEntity? {
        didSet {
            fetchDetailData()
        }
    }
    
    var questionId: Int = -1
    
    // MARK: - UI Components
    
    private let answerDetailView = AnswerDetailView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = answerDetailView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getTodayAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAPI()
        setDelegate()
    }
}

// MARK: - Extensions

extension AnswerDetailViewController {
    func setDelegate() {
        answerDetailView.delegate = self
        answerDetailView.nextDelegate = self
        answerDetailView.homeDelegate = self
    }
    
    func fetchTodayData() {
        guard let todayEntity = todayEntity else { return }
        answerDetailView.setTodayDataBind(model: todayEntity)
        if todayEntity.isMyAnswer && todayEntity.isOpponentAnswer {
            answerDetailView.partnerAnswerContent.isBlurring = false
        } else {
            return
        }
    }
    
    func fetchDetailData() {
        guard let detailEntity = detailEntity else { return }
        answerDetailView.setDetailDataBind(model: detailEntity)
    }
    
    func getAPI() {
        if questionId == -1 {
            getTodayAPI()
        } else {
            getArchivingDetailAPI(row: questionId)
        }
    }
}

extension AnswerDetailViewController: NavigationBarDelegate {
    func backButtonTapped() {
        if isHome {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let keyWindow = windowScene.windows.first else {
                return
            }
            keyWindow.rootViewController = TabBarController()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }

    func completeButtonTapped() {
        
    }
}

extension AnswerDetailViewController: NextButtonDelegate {
    func nextButtonTapped() {
        guard let todayEntity = todayEntity else { return }
        TodayData.shared.section = todayEntity.section ?? ""
        TodayData.shared.index = todayEntity.index ?? 0
        TodayData.shared.topic = todayEntity.topic ?? ""
        TodayData.shared.myQuestion = todayEntity.myQuestion ?? ""
        self.navigationController?.pushViewController(AnswerWriteViewController(), animated: true)
    }
}

extension AnswerDetailViewController: HomeButtonDelegate {
    func homeButtonTapped() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first else {
            return
        }
        keyWindow.rootViewController = TabBarController()
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
    
    func getArchivingDetailAPI(row: Int) {
        ArchivingListService.shared.getArchivingDetailAPI(qnaId: row) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<DetailEntity> {
                    if let detailData = data.data {
                        self.detailEntity = detailData
                    }
                }
            default:
                break
            }
        }
    }
}
