//
//  RecordViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 1/27/24.
//

import UIKit

final class RecordViewController: UIViewController {
    
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
