//
//  ArchivingQuestionItem.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/09.
//

import UIKit

struct ArchivingQuestionItem {
    let qna_id: Int
    let index: Int
    let question: String
}

extension ArchivingQuestionItem {
    
    static func archivingQuestionDummy() -> [ArchivingQuestionItem] {
        return [
            ArchivingQuestionItem (qna_id: 1, index: 1, question:"할머니와 엄마의 꿈이 달랐어?"),
            ArchivingQuestionItem (qna_id: 3, index: 2, question:"할머니와 엄마의 꿈이 달랐어?"),
            ArchivingQuestionItem (qna_id: 9, index: 3, question:"할머니와 엄마의 꿈이 달랐어?"),
            ArchivingQuestionItem (qna_id: 10, index: 4, question:"할머니와 엄마의 꿈이 달랐어?")
        ]
    }
}
