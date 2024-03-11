//
//  UploadViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2/27/24.
//

import UIKit

import RxSwift
import RxCocoa

final class UploadViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let uploadView = UploadView()
    private let disposeBag = DisposeBag()
    private let viewModel: RecordViewModel
    
    // MARK: - Life Cycles
    
    init(viewModel: RecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        view = uploadView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        bindViewModel()
    }
}

// MARK: - Extensions

private extension UploadViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        uploadView.navigationdelegate = self
    }
    
    func bindViewModel() {

        uploadView.uploadCancelView.cancelButton.rx.tap
            .bind {
                self.uploadView.uploadCancelView.isHidden = true
            }
            .disposed(by: disposeBag)
        
        uploadView.uploadCancelView.deleteButton.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
}

extension UploadViewController: NavigationBarDelegate {
    
    @objc
    func backButtonTapped() {
        if uploadView.uploadButton.isEnabled {
            self.uploadView.uploadCancelView.isHidden = false
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func completeButtonTapped() {
    }
    
}
