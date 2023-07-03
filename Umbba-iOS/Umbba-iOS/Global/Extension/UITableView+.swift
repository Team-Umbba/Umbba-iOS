//
//  UITableView+.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/03.
//

import UIKit

extension UITableView {
    
    // 설명: TableView 하단 빈 셀 없애는 메서드
    func setBottomEmptyView() {
        let dummyView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.tableFooterView = dummyView
    }
    
    func fitContentInset(inset: UIEdgeInsets!) {
        self.contentInset = inset
        self.scrollIndicatorInsets = inset
    }
    
    // 설명: TableView 마지막 separator, 빈 셀 separator 숨기는 메서드
    func removeSeparatorsOfEmptyCellsAndLastCell() {
        tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 1)))
    }
}
