//
//  ArchivingSectionItem.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/09.
//

import UIKit

struct ArchivingSectionItem {
    let sectionNum: Int
    let sectionTitle: String
}

extension ArchivingSectionItem {
    
    static func archivingKeywordData() -> [ArchivingSectionItem] {
        return [
            ArchivingSectionItem(sectionNum: 1, sectionTitle: "# 어린 시절"),
            ArchivingSectionItem(sectionNum: 2, sectionTitle: "# 학창 시절"),
            ArchivingSectionItem(sectionNum: 3, sectionTitle: "# 청춘 시절"),
            ArchivingSectionItem(sectionNum: 4, sectionTitle: "# 연애 시절"),
            ArchivingSectionItem(sectionNum: 5, sectionTitle: "# 우리가 만나고")
        ]
    }
}
