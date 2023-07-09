//
//  ArchivingSectionViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/09.
//

import UIKit

final class ArchivingSectionViewController: UIViewController {

    private let archivingSectionView = ArchivingSectionView()
    private var archivingSectionModel: [ArchivingSectionItem] = ArchivingSectionItem.archivingKeywordData()
    
    override func loadView() {
        super.loadView()
        self.view = archivingSectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()

        setRegister()
    }
    
}

private extension ArchivingSectionViewController {

     func setDelegate() {
         archivingSectionView.archivingColletionView.delegate = self
         archivingSectionView.archivingColletionView.dataSource = self
     }
    
    func setRegister() {
        archivingSectionView.archivingColletionView.register(ArchivingSectionCollectionViewCell.self, forCellWithReuseIdentifier: ArchivingSectionCollectionViewCell.identifier)
    }
 }

extension ArchivingSectionViewController: UICollectionViewDelegate {
}

extension ArchivingSectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize = CGSize(width: archivingSectionModel[indexPath.row].keywordTitle.size().width + 32, height: 26)
        return cellSize
    }
}

extension ArchivingSectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArchivingSectionCollectionViewCell.identifier, for: indexPath) as? ArchivingSectionCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setDataBind(model: archivingSectionModel[indexPath.row])
        return cell
    }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return archivingSectionModel.count
     }

 }
