//
//  ArchivingViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/09.
//

import UIKit

import SnapKit

final class ArchivingViewController: UIViewController {
    
    // MARK: - Properties
    
    var headerIndex = 0
    var selectedIndex: Int = 0

    // MARK: - UI Components
    
    private let archivingImageView = ArchivingImageView()
    private let archivingTableView = ArchivingTableView()
    private lazy var tableView = archivingTableView.tableView
    private lazy var archivingHeaderview = ArchivingQuestionTableHeaderView()
    
    private var listEntity: [ListEntity] = []
    
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
        view.addSubviews(archivingImageView, tableView)
    }
    
    private func setLayout() {
        archivingImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 375 / 812)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(archivingImageView.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        archivingTableView.archivingQuestionDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ArchivingViewController: ArchivingQuestionDelegate {
    func archivingQuestionID(qnaId: Int) {
        let nav = AnswerDetailViewController()
        nav.questionId = qnaId
        nav.isHome = false
        nav.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nav, animated: false)
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
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            case .requestErr, .serverErr:
                self.makeAlert(title: "오류가 발생했습니다", message: "다시 시도해주세요")
            default:
                break
            }
        }
    }
}

extension ArchivingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        archivingQuestionID(qnaId: listEntity[indexPath.item].qnaID)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ArchivingQuestionTableHeaderView.dequeueReusableHeaderFooterView(tableView: tableView)
        header.headerLabel.text = I18N.Archiving.sectionArray[headerIndex]
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ArchivingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEntity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ArchivingQuestionTableViewCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
        cell.setDataBind(model: listEntity[indexPath.row])
        return cell
    }
}
