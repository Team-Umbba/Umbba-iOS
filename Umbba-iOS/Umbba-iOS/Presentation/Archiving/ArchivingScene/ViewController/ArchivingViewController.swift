//
//  ArchivingViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/09.
//

import UIKit

import SnapKit

final class ArchivingViewController: UIViewController {
    
    private typealias SectionType = Section
    
    @frozen
    private enum Section: CaseIterable {
        case section, question
    }
    
    private let archivingImageView = ArchivingImageView()
    private lazy var archivingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.setSectionLayout())
    
    private let archivingSectionModel: [ArchivingSectionItem] = ArchivingSectionItem.archivingKeywordData()
    private let archivingQuestionModel: [ArchivingQuestionItem] = ArchivingQuestionItem.archivingQuestionDummy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setHierarchy()
        setLayout()
        registerCell()
        setNavigationUI()
    }
}

extension ArchivingViewController {
    
    private func setUI() {
        view.backgroundColor = .UmbbaWhite
        archivingCollectionView.showsVerticalScrollIndicator = false
        archivingCollectionView.isScrollEnabled = true
        archivingCollectionView.clipsToBounds = true
        archivingCollectionView.contentInsetAdjustmentBehavior = .never
        archivingCollectionView.collectionViewLayout = self.setSectionLayout()
        archivingCollectionView.isUserInteractionEnabled = true
        archivingCollectionView.allowsSelection = true
    }
    
    private func setHierarchy() {
        view.addSubviews(archivingImageView, archivingCollectionView)
    }
    
    private func setLayout() {
        archivingImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        archivingCollectionView.snp.makeConstraints {
            $0.top.equalTo(archivingImageView.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        archivingCollectionView.delegate = self
        archivingCollectionView.dataSource = self
    }
    
    private func registerCell() {
        archivingCollectionView.register(ArchivingSectionCollectionViewCell.self, forCellWithReuseIdentifier: ArchivingSectionCollectionViewCell.identifier)
        archivingCollectionView.register(ArchivingQuestionCollectionViewCell.self, forCellWithReuseIdentifier: ArchivingQuestionCollectionViewCell.identifier)
        
        archivingCollectionView.register(ArchivingQuestionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ArchivingQuestionHeaderView")
    }
    
    func setNavigationUI() {
        navigationItem.title = I18N.Archiving.navigationTitle
        navigationItem.leftBarButtonItem?.tintColor = .UmbbaBlack
    }
    
    func setSectionLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, env -> NSCollectionLayoutSection? in
            let sectionType = Section.allCases[sectionIndex]
            switch sectionType {
            case .section:
                return self.getLayoutSection()
            case .question:
                return self.getLayoutQuestion()
            }
        }
    }
    
    func getLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(100),
            heightDimension: .absolute(26)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.5),
            heightDimension: .absolute(26)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.interItemSpacing = .fixed(12)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func getLayoutQuestion() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(60)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(60)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(48)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
}

extension ArchivingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = Section.allCases[indexPath.section]
        switch sectionType {
        case .section:
            print("asdf")
        case .question:
            print("iroi")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        print("shouldSelectItemAt")
        return true
    }
}

extension ArchivingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = Section.allCases[indexPath.section]
        switch sectionType {
        case .section:
            guard let cell = archivingCollectionView.dequeueReusableCell(withReuseIdentifier: ArchivingSectionCollectionViewCell.identifier, for: indexPath) as? ArchivingSectionCollectionViewCell else { return UICollectionViewCell() }
            cell.setDataBind(model: archivingSectionModel[indexPath.row])
            return cell
        case .question:
            guard let cell = archivingCollectionView.dequeueReusableCell(withReuseIdentifier: ArchivingQuestionCollectionViewCell.identifier, for: indexPath) as? ArchivingQuestionCollectionViewCell else { return UICollectionViewCell() }
            cell.setDataBind(model: archivingQuestionModel[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = SectionType.allCases[section]
        switch sectionType {
        case .section:
            return archivingSectionModel.count
        case .question:
            return archivingQuestionModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionType = SectionType.allCases[indexPath.section]
        switch sectionType {
        case .section:
            let view = UICollectionReusableView()
            return view
        case .question:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ArchivingQuestionHeaderView", for: indexPath) as! ArchivingQuestionHeaderView
            return headerView
        }
    }
}

extension ArchivingViewController: UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
}
