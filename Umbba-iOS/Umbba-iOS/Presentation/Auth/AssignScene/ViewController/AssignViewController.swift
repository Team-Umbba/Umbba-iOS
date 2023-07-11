//
//  AssignViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/11.
//

import UIKit

final class AssignViewController: UIViewController {
    
    private let assignView = AssignView()
    
    override func loadView() {
        super.loadView()
        
        self.view = assignView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
