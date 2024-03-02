//
//  QuizViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 1/31/24.
//

import UIKit

class QuizViewController: UIViewController {

    private let quizView = QuizView()
    
    override func loadView() {
        super.loadView()
        
        view = quizView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

private extension QuizViewController {
   
}
