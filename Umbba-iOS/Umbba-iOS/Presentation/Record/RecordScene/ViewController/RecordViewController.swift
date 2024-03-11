//
//  RecordViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 1/27/24.
//

import UIKit

import RxSwift
import RxCocoa

final class RecordViewController: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let recordViewModel = RecordViewModel()
    
    // MARK: - UI Components
    
    private let recordView = RecordView()
    private lazy var collectionView = recordView.recordCollectionView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        
        view = recordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        bindViewModel()
    }
}

// MARK: - Extensions

extension RecordViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        recordView.navigationdelegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.albumeDeleted(_:)), name: NSNotification.Name("albumDeleted"), object: nil)
    }
    
    @objc func albumeDeleted(_ notification: Notification) {
        recordViewModel.inputs.getAlbum()
        self.collectionView.reloadData()
    }
    
    func bindViewModel() {
        recordView.recordButton.rx.tap
            .subscribe(onNext: {
                let albumVC = UIImagePickerController()
                albumVC.sourceType = .photoLibrary
                albumVC.delegate = self
                albumVC.allowsEditing = true
                self.present(albumVC, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        recordViewModel.outputs.albumData
            .subscribe(onNext: { [weak self] albums in
                guard let self = self else { return }
                if albums.isEmpty {
                    self.recordView.configureView(.emptyRecord)
                } else {
                    self.recordView.configureView(.hasRecord)
                }
                self.recordView.setNeedsDisplay()
            })
            .disposed(by: disposeBag)
        
        recordViewModel.outputs.albumData
            .bind(to: recordView.recordCollectionView.rx
                .items(cellIdentifier: RecordCollectionViewCell.className,
                       cellType: RecordCollectionViewCell.self)) { (index, model, cell) in
                cell.configureCell(model: model)
                cell.recordDeleteButton.rx.tap
                    .subscribe(onNext: {
                        let nav = DeleteRecordAlertViewController(viewModel: self.recordViewModel, idx: model.albumID)
                        nav.modalPresentationStyle = .overFullScreen
                        self.present(nav, animated: false)
                    })
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
    }
}

extension RecordViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if info[.editedImage] is UIImage {
            let nav = UploadViewController()
            self.navigationController?.pushViewController(nav, animated: true)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RecordViewController: UINavigationControllerDelegate {
    
}

extension RecordViewController: NavigationBarDelegate {
    
    @objc
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
    }
    
}
