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
import FirebaseDynamicLinks

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
                self.share()
            }
        case 3:
            self.makeAlert(alertType: .disconnectAlert) {}
        default:
            break
        }
    }
    
    func share() {
        guard let inviteCode = inviteCode.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        guard let link = URL(string: "https://umbba.page.link/umbba?code=" + inviteCode) else { return }
        let dynamicLinkComponents = DynamicLinkComponents(link: link, domainURIPrefix: "https://umbba.page.link/umbba")
        
        guard let longDynamic = dynamicLinkComponents?.url else { return }
        let inviteText = "'\(inviteUserName)' 으로부터 초대가 왔어요💌\n\n당신의 가장 오래된 기억이 무엇인가요?\n과거로 떠나 함께 추억을 나누고, 공감대를 형성해보세요.\n\n어플 설치 후 하단의 초대코드를 입력해, 상대방과 연결하세요\n\n초대코드 : \(inviteCode)\n\n\(link)"
        
        let activityVC = UIActivityViewController(activityItems: [inviteText], applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.mail, UIActivity.ActivityType.postToFacebook]
        
        activityVC.completionWithItemsHandler = { [weak self] (activityType, completed, _, error) in
            if completed {
                print("초대코드 공유 완료")
            }
            if let error = error {
                print("초대코드 공유 오류: \(error.localizedDescription)")
            }
            self?.dismiss(animated: true, completion: nil)
        }
        
        present(activityVC, animated: true, completion: nil)
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
