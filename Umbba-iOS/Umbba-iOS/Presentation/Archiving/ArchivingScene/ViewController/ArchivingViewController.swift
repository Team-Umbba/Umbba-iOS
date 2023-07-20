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
    
    var headerIndex = 0
    var selectedIndex: Int = 0
    
    @frozen
    private enum Section: CaseIterable {
        case section, question
    }
    
    // MARK: - UI Components
    
    private let archivingImageView = ArchivingImageView()
    private let archivingCollectionView = ArchivingCollectionView()
    private lazy var collectionView = archivingCollectionView.ArchivingCollectionView
    private lazy var archivingHeaderview = ArchivingQuestionHeaderView()
    
    private var listEntity: [ListEntity] = [] {
        didSet {
            self.collectionView.reloadSections([1])
        }
    }
    
    private let deviceRatio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getListAPI(row: 1)
        setUI()
        setDelegate()
        setHierarchy()
        setLayout()
    }
}

// MARK: - Extensions

extension ArchivingViewController {
    
    private func setUI() {
        view.backgroundColor = .UmbbaWhite
        archivingImageView.contentMode = .scaleAspectFill
    }
    
    private func setHierarchy() {
        view.addSubviews(archivingImageView, collectionView)
    }
    
    private func setLayout() {
        archivingImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 375 / 812)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(archivingImageView.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        archivingCollectionView.archivingQuestionDelegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func updateHeaderLabel(_ text: String) {
        if let headerView = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 1)) as? ArchivingQuestionHeaderView {
            headerView.headerLabel.text = text
        }
    }
}

extension ArchivingViewController: ArchivingQuestionDelegate {
    func archivingQuestionID(qnaId: Int) {
        let nav = AnswerDetailViewController()
        nav.questionId = qnaId
        self.navigationController?.pushViewController(nav, animated: true)
    }
}

// MARK: - Network

private extension ArchivingViewController {
    func getListAPI(row: Int) {
        ArchivingListService.shared.getArchivingListAPI(sectionId: row) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<[ListEntity]> {
                    if let listData = data.data {
                        self.listEntity = listData
                    }
                }
            default:
                break
            }
        }
    }
}

extension ArchivingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = Section.allCases[indexPath.section]
        switch sectionType {
        case .section:
            getListAPI(row: indexPath.item + 1)
            selectedIndex = indexPath.item
            if SizeLiterals.Screen.deviceRatio > 0.5 {
                archivingImageView.setSEDataBind(section: indexPath.item)
                headerIndex = indexPath.item
            } else {
                archivingImageView.setDataBind(section: indexPath.item)
                headerIndex = indexPath.item
            }
            collectionView.reloadData()
        case .question:
            print(listEntity[indexPath.item].qnaID)
            archivingQuestionID(qnaId: listEntity[indexPath.item].qnaID)
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
            cell.archivingSectionLabel.text = "# \(I18N.Archiving.sectionArray[indexPath.item])"
            cell.setTest(isSelected: selectedIndex == indexPath.item)
            
            return cell
        case .question:
            let cell = ArchivingQuestionCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.setDataBind(model: listEntity[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = SectionType.allCases[section]
        switch sectionType {
        case .section:
            return I18N.Archiving.sectionArray.count
        case .question:
            return listEntity.count
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
            headerView.headerLabel.text = I18N.Archiving.sectionArray[headerIndex]
            return headerView
        }
    }
}

extension ArchivingViewController: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
}
