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
    
    // MARK: - Properties
    
    private var myPageEntity: MyPageEntity? {
        didSet {
            fetchMyPageData()
        }
    }
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = mypageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMyPageAPI()
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
            let quizViewController = QuizViewController()
            quizViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(quizViewController, animated: true)
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
}
