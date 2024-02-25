//
//  EndingViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/08/25.
//

import UIKit

import SafariServices

final class EndingViewController: UIViewController {
    
    // MARK: - Properties
    
    private var restartEntity = RestartEntity()
    
    // MARK: - UI Components
    
    private let endingView = EndingView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = endingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
    }
}

// MARK: - Extensions

private extension EndingViewController {
    
    func setDelegate() {
        endingView.endingDelegate = self
    }
}

extension EndingViewController: EndingDelegate {
    
    func exitButtonTapped() {
        self.navigationController?.popViewController(animated: false)
    }
    
    func continueButtonTapped() {
        patchRestartAPI()
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first else {
            return
        }
        keyWindow.rootViewController = TabBarController()
    }
    
    func surveyButtonTapped() {
        if let url = URL(string: I18N.Setting.urlArray[3]) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
}

// MARK: - Network

extension EndingViewController {
    
    func patchRestartAPI() {
        HomeService.shared.patchRestartAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<RestartEntity> {
                    if let restartData = data.data {
                        self.restartEntity = restartData
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
