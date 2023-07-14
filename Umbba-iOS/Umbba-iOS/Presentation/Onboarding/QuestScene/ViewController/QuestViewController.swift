//
//  QuestViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/15.
//

import UIKit

final class QuestViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let questView = QuestView()
    private lazy var questCollectionView = questView.questCollectionView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = questView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        registerCell()
    }
}

// MARK: - Extensions

private extension QuestViewController {
    
    func setDelegate() {
        questView.navigationdelegate = self
        questView.nextDelegate = self
        questCollectionView.delegate = self
        questCollectionView.dataSource = self
    }
    
    func registerCell() {
        QuestCollectionViewCell.register(target: questCollectionView)
    }
}

extension QuestViewController: NavigationBarDelegate {
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func completeButtonTapped() {
        
    }
}

extension QuestViewController: NextButtonDelegate {
    func nextButtonTapped() {
        print("클릭")
        guard let currentIndexPath = questCollectionView.indexPathsForVisibleItems.first else {
            return
        }
        
        let nextIndexPath = IndexPath(item: currentIndexPath.item + 1, section: currentIndexPath.section)
        questCollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }
    //        self.navigationController?.pushViewController(), animated: true)
}

extension QuestViewController: UICollectionViewDelegate {
    
}

extension QuestViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = QuestCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        cell.questionLabel.text = "질문 질문 질문 질문 질문 질문 질문 질문 질문"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}

extension QuestViewController: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
