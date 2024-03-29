//
//  ArchivingTableView.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/09/17.
//

import UIKit

import SnapKit

protocol ArchivingQuestionDelegate: AnyObject {
    func archivingQuestionID(qnaId: Int)
}

final class ArchivingTableView: UIView {
    
    // MARK: - Protocols
    
    weak var archivingQuestionDelegate: ArchivingQuestionDelegate?
    
    // MARK: - UI Components
    
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setTableView()
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension ArchivingTableView {
    
    func setUI() {
        backgroundColor = .White500
    }
    
    func setHierarchy() {
        addSubview(tableView)
    }
    
    func setLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setTableView() {
        tableView.backgroundColor = .White500
        tableView.sectionFooterHeight = 0
        tableView.sectionHeaderTopPadding = 0 
        tableView.isScrollEnabled = true
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .none
    }
    
    func registerCell() {
        ArchivingQuestionTableViewCell.register(target: tableView)
        ArchivingQuestionTableHeaderView.register(target: tableView)
    }
    
    @objc
    func archivingQuestionID(qnaId: Int) {
        archivingQuestionDelegate?.archivingQuestionID(qnaId: qnaId)
    }
}
