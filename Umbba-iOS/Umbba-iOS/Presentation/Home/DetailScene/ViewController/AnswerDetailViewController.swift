//
//  AnswerDetailViewController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/13.
//

import UIKit

final class AnswerDetailViewController: UIViewController {
    
    // MARK: - Properties
    
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
        
        routeAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routeAPI()
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
    
    func routeAPI() {
        if isHome {
            getTodayAPI()
        } else {
            getArchivingDetailAPI(row: questionId)
        }
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
            self.navigationController?.popViewController(animated: false)
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
        LoadingView.shared.show(self.view)
        HomeService.shared.getTodayAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<TodayEntity> {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
//                        LoadingView.shared.hide() {
//                            print("로딩 종료")
//                        }
//                    }
                    LoadingView.shared.hide() {
                        print("로딩 종료")
                    }
                    if let todayData = data.data {
                        self.todayEntity = todayData
                    }
                }
            case .requestErr, .serverErr:
                self.makeAlert(title: "오류가 발생했습니다", message: "다시 시도해주세요")
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
            case .requestErr, .serverErr:
                self.makeAlert(title: "오류가 발생했습니다", message: "다시 시도해주세요")
            default:
                break
            }
        }
    }
}
