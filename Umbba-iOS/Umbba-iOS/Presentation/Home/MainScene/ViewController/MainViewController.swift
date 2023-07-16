//
//  MainViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/14.
//

import UIKit

final class MainViewController: UIViewController {
    
    var response_case: Int = 1
    
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
        switch response_case {
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
            self.makeAlert(alertType: .inviteAlert) {}
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
