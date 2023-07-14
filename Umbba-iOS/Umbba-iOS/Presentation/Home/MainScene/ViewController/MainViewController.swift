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
