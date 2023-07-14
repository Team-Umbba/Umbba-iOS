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
        
        setDataBind()
    }
}

extension MainViewController {
    private func setDataBind() {
        mainView.setDataBind(model: mainModel)
    }
}
