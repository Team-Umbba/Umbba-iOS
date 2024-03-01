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
    
    // MARK: - UI Components
    
    private let recordView = RecordView()
    private lazy var collectionView = recordView.collectionView
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
        recordView.navigationdelegate = self
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
    }
}

extension RecordViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
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

extension RecordViewController: UICollectionViewDelegate {
    
}

extension RecordViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = RecordCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        return cell
    }
}

extension RecordViewController: NavigationBarDelegate {
    
    @objc
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
    }
    
}
