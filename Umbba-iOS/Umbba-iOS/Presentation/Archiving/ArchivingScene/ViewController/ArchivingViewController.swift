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
    private lazy var archivingHeaderview = ArchivingQuestionHeaderView()
    
    private var listEntity: [ListEntity] = []
    
    private var selectedSectionIndexPath: Int?
    private let deviceRatio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getListAPI(row: 1)
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
        archivingImageView.contentMode = .scaleAspectFill
    }
    
    private func setHierarchy() {
        view.addSubviews(archivingImageView, collectionView)
    }
    
    private func setLayout() {
        archivingImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 375 / 812)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 375 / 812)
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
    
    func updateHeaderLabel(_ text: String) {
        if let headerView = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 1)) as? ArchivingQuestionHeaderView {
            headerView.headerLabel.text = text
        }
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
                        self.collectionView.reloadData()
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
            if let cell = collectionView.cellForItem(at: indexPath) as? ArchivingSectionCollectionViewCell {
                cell.backgroundColor = .Primary600
                cell.archivingSectionLabel.textColor = .UmbbaWhite
                
                if SizeLiterals.Screen.deviceRatio > 0.5 {
                    archivingImageView.setSEDataBind(section: indexPath.row)
                    updateHeaderLabel(I18N.Archiving.sectionArray[indexPath.row])
                } else {
                    archivingImageView.setDataBind(section: indexPath.row)
                    updateHeaderLabel(I18N.Archiving.sectionArray[indexPath.row])
                }
                getListAPI(row: indexPath.row + 1)
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
            cell.tag = indexPath.item
            cell.archivingSectionLabel.text = "# \(I18N.Archiving.sectionArray[indexPath.row])"
            if indexPath.item == 0 {
                cell.backgroundColor = .Primary600
                cell.archivingSectionLabel.textColor = .UmbbaWhite
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
                
                if deviceRatio > 0.5 {
                    archivingImageView.setSEDataBind(section: indexPath.row)
                } else {
                    archivingImageView.setDataBind(section: indexPath.row)
                }
            }
            return cell
        case .question:
            let cell = ArchivingQuestionCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.setDataBind(model: listEntity[0])
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
            headerView.headerLabel.text = I18N.Archiving.sectionArray[0]
            return headerView
        }
    }
}

extension ArchivingViewController: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
}

extension ArchivingViewController: ArchivingDelegate {
    func labelTapped(index: Int) {
        collectionView.visibleCells.forEach { cell in
            guard let cell = cell as? ArchivingSectionCollectionViewCell else { return }
            let isSelected = cell.tag == index
            cell.updateCell(isSelected)
        }
    }
}
