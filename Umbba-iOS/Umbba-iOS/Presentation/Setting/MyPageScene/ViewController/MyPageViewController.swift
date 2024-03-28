//
//  MyPageViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 1/30/24.
//

import UIKit

import SnapKit

final class MyPageViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let mypageView = MyPageView()
    private let quizView = QuizView()
    private let resultView = ResultView()
    
    // MARK: - Properties
    
    private var myPageEntity: MyPageEntity? {
        didSet {
            fetchMyPageData()
        }
    }
    
    private var quizEntity: QuizEntity? 
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = mypageView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getQuizAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMyPageAPI()
        getQuizAPI()
        setDelegate()
        setGesture()
    }
}

// MARK: - Extensions

private extension MyPageViewController {
    func setDelegate() {
        mypageView.delegate = self
    }
    
    func fetchMyPageData() {
        guard let myPageEntity = myPageEntity else { return }
        mypageView.setDataBind(model: myPageEntity)
    }
    
    @objc
    func albumViewTapped() {
        if myPageEntity?.opponentUsername == nil {
            guard let inviteCode = myPageEntity?.inviteCode  else { return }
            guard let inviteUsername = myPageEntity?.myUsername else { return }
            guard let installURL = myPageEntity?.installURL else { return }
            NotificationCenter.default.post(name: Notification.Name("share"), object: nil, userInfo: ["inviteCode": inviteCode, "inviteUserName": inviteUsername, "installURL": installURL])
        } else {
            let recordViewController = RecordViewController()
            recordViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(recordViewController, animated: true)
        }
    }
    
    @objc
    func relationViewTapped() {
        if myPageEntity?.opponentUsername == nil {
            guard let inviteCode = myPageEntity?.inviteCode  else { return }
            guard let inviteUsername = myPageEntity?.myUsername else { return }
            guard let installURL = myPageEntity?.installURL else { return }
            NotificationCenter.default.post(name: Notification.Name("share"), object: nil, userInfo: ["inviteCode": inviteCode, "inviteUserName": inviteUsername, "installURL": installURL])
        } else {
            guard let quizEntity = quizEntity else { return }
            if quizEntity.responseCase == 1 {
                let quizViewController = QuizViewController()
                quizViewController.quizEntity = self.quizEntity
                quizViewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(quizViewController, animated: true)
                
            } else {
                let resultViewController = ResultViewController()
                resultViewController.quizEntity = self.quizEntity
                resultViewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(resultViewController, animated: true)
            }
        }
    }
}

extension MyPageViewController: UIGestureRecognizerDelegate {
    func setGesture() {
        let relationTapGesture = UITapGestureRecognizer(target: self, action: #selector(relationViewTapped))
        mypageView.relationView.addGestureRecognizer(relationTapGesture)
        let albumTapGesture = UITapGestureRecognizer(target: self, action: #selector(albumViewTapped))
        mypageView.albumView.addGestureRecognizer(albumTapGesture)
    }
}

extension MyPageViewController: SettingButtonDelegate {
    @objc
    func settingButtonTapped() {
        let settingViewController = SettingViewController()
        settingViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }
}

// MARK: - Network

extension MyPageViewController {
    func getMyPageAPI() {
        MyPageService.shared.getMyPageAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<MyPageEntity> {
                    if let myPageData = data.data {
                        self.myPageEntity = myPageData
                    }
                }
            case .requestErr, .serverErr:
                self.makeAlert(title: "오류가 발생했습니다", message: "다시 시도해주세요")
            default:
                break
            }
        }
    }
    
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
}
