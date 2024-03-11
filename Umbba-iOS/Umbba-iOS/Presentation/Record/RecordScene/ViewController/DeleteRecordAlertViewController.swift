//
//  DeleteRecordAlertViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 3/9/24.
//

import UIKit

import RxSwift
import RxCocoa

final class DeleteRecordAlertViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: RecordViewModel
    private var albumIdx: Int = 0
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    
    private let deleteAlertView = DeleteRecordAlertView()
    
    // MARK: - Life Cycles
    
    init(viewModel: RecordViewModel, idx: Int) {
        self.viewModel = viewModel
        self.albumIdx = idx
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        view = deleteAlertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
}

// MARK: - Extensions

extension DeleteRecordAlertViewController {

    func bindViewModel() {
        deleteAlertView.deleteButton.rx.tap
            .bind {
                self.viewModel.inputs.deleteButtonTapped(idx: self.albumIdx)
                NotificationCenter.default.post(name: NSNotification.Name("albumDeleted"), object: nil)
                self.dismiss(animated: false)
            }
            .disposed(by: disposeBag)
        
        deleteAlertView.cancelButton.rx.tap
            .bind {
                self.dismiss(animated: false)
            }
            .disposed(by: disposeBag)
    }
}
