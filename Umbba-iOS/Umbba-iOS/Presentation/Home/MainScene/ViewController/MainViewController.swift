//
//  MainViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/14.
//

import UIKit

final class MainViewController: UIViewController {
    
    var response_case: Int = 1
    
    private let mainModel: MainItem = MainItem.mainDummy()
    private let mainView = MainView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setDataBind()
    }
}

private extension MainViewController {
    func setDelegate() {
        mainView.mainDelegate = self
        
        let deviceRatio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
        if deviceRatio > 0.5 {
            mainView.setSEImageBind(model: mainModel)
        } else {
            mainView.setImageBind(model: mainModel)
        }
    }
    
    func setDataBind() {
        mainView.setDataBind(model: mainModel)
    }
}

extension MainViewController: MainDelegate {
    func questionButtonTapped() {
        switch response_case {
        case 1: // 답변 화면으로 이동
            self.navigationController?.pushViewController(AnswerDetailViewController(), animated: true)
        case 2:
            self.makeAlert(alertType: .inviteAlert) {}
        case 3:
            self.makeAlert(alertType: .disconnectAlert) {}
        default:
            break
        }
    }
}
