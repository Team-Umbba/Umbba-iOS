//
//  AnswerDetailViewController.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/13.
//

import UIKit

class AnswerDetailViewController: UIViewController {
    
    private let answerDetailView = AnswerDetailView()
    
    override func loadView() {
        super.loadView()
        
        view = answerDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
