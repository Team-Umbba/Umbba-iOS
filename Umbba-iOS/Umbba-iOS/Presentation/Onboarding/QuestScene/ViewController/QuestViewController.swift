//
//  QuestViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/15.
//

import UIKit

final class QuestViewController: UIViewController {
    
    // MARK: - Properties
    
    var isReceiver: Bool = false
    
    // MARK: - UI Components
    
    private let questView = QuestView()
    private lazy var questCollectionView = questView.questCollectionView
    private lazy var progressView = questView.progressView
    private lazy var nextButton = questView.nextButton
    
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
        guard let currentIndexPath = questCollectionView.indexPathsForVisibleItems.first else { return }
        if currentIndexPath.item == 0 {
            self.navigationController?.popViewController(animated: true)
        } else {
            progressView.progress = Float(currentIndexPath.item) * 0.2
            let previousIndexPath = IndexPath(item: currentIndexPath.item - 1, section: currentIndexPath.section)
            questCollectionView.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func completeButtonTapped() {
        
    }
}

extension QuestViewController: NextButtonDelegate {
    func nextButtonTapped() {
        guard let currentIndexPath = questCollectionView.indexPathsForVisibleItems.first else { return }
        if currentIndexPath.item == 4 {
            if isReceiver {
                self.navigationController?.pushViewController(NoticeAlarmViewController(), animated: true)
            } else {
                self.navigationController?.pushViewController(PushAlarmViewController(), animated: true)
            }
        } else {
            nextButton.isEnabled = false
            progressView.progress = Float(currentIndexPath.item + 2) * 0.2
            let nextIndexPath = IndexPath(item: currentIndexPath.item + 1, section: currentIndexPath.section)
            questCollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension QuestViewController: UICollectionViewDelegate {
    
}

extension QuestViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = QuestCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        cell.questionLabel.text = "질문 질문 질문 질문 질문 질문 질문 질문 질문 질문 질문"
        cell.questDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}

extension QuestViewController: QuestDelegte {
    func updateNextButton(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
    }
}
