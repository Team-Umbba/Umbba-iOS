//
//  ResultViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 3/2/24.
//

import UIKit

final class ResultViewController: UIViewController {

    private let resultView = ResultView()
    
    override func loadView() {
        super.loadView()
        
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
    }
    
}

private extension ResultViewController {
    func setDelegate() {
        resultView.navigationdelegate = self
    }
}

extension ResultViewController: NavigationBarDelegate {
    @objc
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
        
    }
}
