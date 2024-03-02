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
        
        setDelegate()
    }
    
}

private extension QuizViewController {
    
    func setDelegate() {
        quizView.navigationdelegate = self
        quizView.nextDelegate = self
    }
    
}

extension QuizViewController: NavigationBarDelegate {
    @objc
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
        
    }
}

extension QuizViewController: NextButtonDelegate {
    func nextButtonTapped() {
        self.navigationController?.pushViewController(ResultViewController(), animated: true)
    }
}
