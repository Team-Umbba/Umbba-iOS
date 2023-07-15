//
//  MainViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/14.
//

import UIKit

final class MainViewController: UIViewController {
    
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
        self.navigationController?.pushViewController(AnswerDetailViewController(), animated: false)
    }
}
