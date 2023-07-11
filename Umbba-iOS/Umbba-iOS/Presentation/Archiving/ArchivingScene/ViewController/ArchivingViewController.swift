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
    
    // MARK: - UI Components
    
    private let archivingImageView = ArchivingImageView()
    private let archivingCollectionView = ArchivingCollectionView()
    private lazy var collectionView = archivingCollectionView.ArchivingCollectionView
    
    private let archivingQuestionModel: [ArchivingQuestionItem] = ArchivingQuestionItem.archivingQuestionDummy()
    
    private var selectedSectionIndexPath: Int?
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setHierarchy()
        setLayout()
        setNavigationUI()
    }
}

// MARK: - Extensions

extension ArchivingViewController {
    
    private func setUI() {
        view.backgroundColor = .UmbbaWhite
    }
    
    private func setHierarchy() {
        view.addSubviews(archivingImageView, collectionView)
    }
    
    private func setLayout() {
        archivingImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(archivingImageView.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setNavigationUI() {
        navigationItem.title = I18N.Archiving.navigationTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.PretendardRegular(size: 16), .foregroundColor: UIColor.UmbbaBlack]
    }
}

extension ArchivingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = Section.allCases[indexPath.section]
        switch sectionType {
        case .section:
            selectedSectionIndexPath = indexPath.row
            if let cell = collectionView.cellForItem(at: indexPath) as? ArchivingSectionCollectionViewCell {
                cell.backgroundColor = .Primary600
                cell.archivingSectionLabel.textColor = .UmbbaWhite
            }
        case .question:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let sectionType = Section.allCases[indexPath.section]
        switch sectionType {
        case .section:
            if let cell = collectionView.cellForItem(at: indexPath) as? ArchivingSectionCollectionViewCell {
                cell.backgroundColor = .UmbbaWhite
                cell.archivingSectionLabel.textColor = .Primary600
            }
        case .question:
            break
        }
    }
}

extension ArchivingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = SectionType.allCases[indexPath.section]
        switch sectionType {
        case .section:
            let cell =
                    ArchivingSectionCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.archivingSectionLabel.text = "# \(I18N.Archiving.sectionArray[indexPath.row])"
            if indexPath.item == 1 {
                cell.backgroundColor = .Primary600
                cell.archivingSectionLabel.textColor = .UmbbaWhite
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            }
            return cell
        case .question:
            let cell = ArchivingQuestionCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.setDataBind(model: archivingQuestionModel[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = SectionType.allCases[section]
        switch sectionType {
        case .section:
            return I18N.Archiving.sectionArray.count
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
            let headerView = ArchivingQuestionHeaderView.dequeueReusableHeaderView(collectionView: collectionView, indexPath: indexPath)
            headerView.setDataBind(model: archivingQuestionModel[indexPath.row])
            return headerView
        }
    }
}

extension ArchivingViewController: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
}
