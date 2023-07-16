//
//  MainViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/14.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private var caseEntity: CaseEntity?
    private var mainEntity: MainEntity? {
        didSet {
            fetchData()
        }
    }
    private let mainView = MainView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMainAPI()
        getCaseAPI()
        setDelegate()
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
}

extension MainViewController: MainDelegate {
    func questionButtonTapped() {
        guard let caseEntity = caseEntity else { return }
        switch caseEntity.responseCase {
        case 1:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let keyWindow = windowScene.windows.first else {
                return
            }
            keyWindow.rootViewController = UINavigationController(rootViewController: AnswerDetailViewController())
            if let navigationController = keyWindow.rootViewController as? UINavigationController {
                navigationController.isNavigationBarHidden = true
            }
        case 2:
            guard let inviteCode = caseEntity.inviteCode  else { return }
            guard let inviteUsername = caseEntity.inviteUsername else { return }
            guard let installURL = caseEntity.installURL else { return }
            self.makeAlert(inviteCode: inviteCode, inviteUsername: inviteUsername, installURL: installURL) {}
        case 3:
            self.makeAlert(alertType: .disconnectAlert) {}
        default:
            break
        }
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
                    }
                }
            default:
                break
            }
        }
    }
}
