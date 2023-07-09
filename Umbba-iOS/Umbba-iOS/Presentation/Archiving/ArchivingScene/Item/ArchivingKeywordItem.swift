//
//  ArchivingKeywordItem.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/09.
//

import UIKit

struct ArchivingSectionItem {
    let ketwordNum: Int
    let keywordTitle: String
    var keywordTapped: Bool
}

extension ArchivingSectionItem {
    
    static func archivingKeywordData() -> [ArchivingSectionItem] {
        return [
            ArchivingSectionItem(ketwordNum: 1, keywordTitle: "# 어린 시절", keywordTapped: false),
            ArchivingSectionItem(ketwordNum: 2, keywordTitle: "# 학창 시절", keywordTapped: false),
            ArchivingSectionItem(ketwordNum: 3, keywordTitle: "# 청춘 시절", keywordTapped: false),
            ArchivingSectionItem(ketwordNum: 4, keywordTitle: "# 연애 시절", keywordTapped: false),
            ArchivingSectionItem(ketwordNum: 5, keywordTitle: "# 우리가 만나고", keywordTapped: false)
        ]
    }
}
