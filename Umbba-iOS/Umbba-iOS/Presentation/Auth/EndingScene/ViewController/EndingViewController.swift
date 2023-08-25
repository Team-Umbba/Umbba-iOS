//
//  EndingViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/08/25.
//

import UIKit

final class EndingViewController: UIViewController {
    
    private let endingView = EndingView()
    
    override func loadView() {
        super.loadView()
        self.view = endingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
