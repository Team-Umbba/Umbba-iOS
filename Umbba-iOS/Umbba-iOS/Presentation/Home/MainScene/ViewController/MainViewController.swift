//
//  MainViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/14.
//

import UIKit

import KakaoSDKCommon
import KakaoSDKTemplate
import KakaoSDKShare

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private var caseEntity: CaseEntity? {
        didSet {
            fetchData()
        }
    }
    
    private var mainEntity: MainEntity? {
        didSet {
            fetchData()
        }
    }
    var inviteCode: String = ""
    var inviteUserName: String = ""
    
    // MARK: - UI Components
    
    private let mainView = MainView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMainAPI()
        getCaseAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegate()
        getCaseAPI()
        getMainAPI()
    }
}

private extension MainViewController {
    func setDelegate() {
        mainView.mainDelegate = self
    }
    
    func fetchData() {
        guard let mainEntity = mainEntity else { return }
        mainView.setDataBind(model: mainEntity)
        if SizeLiterals.Screen.deviceRatio > 0.5 {
            mainView.setSEImageBind(model: mainEntity)
        } else {
            mainView.setImageBind(model: mainEntity)
        }
        
        if mainEntity.index > 7 {
            getEndingPage()
        } else {
            return
        }
    }
    
    func setNextController() {
        switch caseEntity?.responseCase {
        case 1:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let keyWindow = windowScene.windows.first else {
                return
            }
            let answerDetailController = AnswerDetailViewController()
            answerDetailController.isHome = true
            keyWindow.rootViewController = UINavigationController(rootViewController: answerDetailController)
            if let navigationController = keyWindow.rootViewController as? UINavigationController {
                navigationController.isNavigationBarHidden = true
            }
        case 2:
            guard let inviteCode = caseEntity?.inviteCode  else { return }
            guard let inviteUsername = caseEntity?.inviteUsername else { return }
            guard let installURL = caseEntity?.installURL else { return }
            self.makeAlert(inviteCode: inviteCode, inviteUsername: inviteUsername, installURL: installURL) {
                self.kakao()
            }
        case 3:
            self.makeAlert(alertType: .disconnectAlert) {}
        default:
            break
        }
    }
    
    func kakao() {
        let feedTemplateJsonStringData =
            """
            {
                "object_type": "feed",
                "content": {
                    "title": "'\(inviteUserName)'으로부터 초대가 왔어요.\\n초대 코드 : \(inviteCode) ",
                    "description": "과거로 떠나 함께 추억을 나누고,\\n공감대를 형성해보세요.",
                    "image_url": "https://github.com/Team-Umbba/Umbba-iOS/assets/75068759/64ba7265-9148-4f06-8235-de5f4030e92f",
                    "link": {
                        "mobile_web_url": "https://developers.kakao.com",
                        "web_url": "https://developers.kakao.com"
                    }
                },
                "buttons": [
                    {
                        "title": "초대 받기",
                        "link": {
                            "android_execution_params": "key1=value1&key2=value2",
                            "ios_execution_params": "key1=value1&key2=value2"
                        }
                    }
                ]
            }
            """.data(using: .utf8)!
        
        if let templateJsonObject = SdkUtils.toJsonObject(feedTemplateJsonStringData) {
            if ShareApi.isKakaoTalkSharingAvailable() {
                ShareApi.shared.shareDefault(templateObject: templateJsonObject) {(linkResult, error) in
                    if let error = error {
                        print("error : \(error)")
                    } else {
                        print("defaultLink(templateObject:templateJsonObject) success.")
                        guard let linkResult = linkResult else { return }
                        UIApplication.shared.open(linkResult.url, options: [:], completionHandler: nil)
                    }
                }
            } else {
                let url = "itms-apps://itunes.apple.com/app/362057947"
                if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
        }
    }
}

extension MainViewController: MainDelegate {
    func questionButtonTapped() {
        getCaseAPI()
        setNextController()
    }
}

// MARK: - Network

private extension MainViewController {
    func getMainAPI() {
        HomeService.shared.getHomeAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<MainEntity> {
                    if let mainData = data.data {
                        self.mainEntity = mainData
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

extension MainViewController {
    func getCaseAPI() {
        HomeService.shared.getCaseAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<CaseEntity> {
                    if let caseData = data.data {
                        self.caseEntity = caseData
                        self.inviteUserName = caseData.inviteUsername ?? ""
                        self.inviteCode = caseData.inviteCode ?? ""
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

extension MainViewController {
    func getEndingPage() {
        let nav = EndingViewController()
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: false)
    }
}
