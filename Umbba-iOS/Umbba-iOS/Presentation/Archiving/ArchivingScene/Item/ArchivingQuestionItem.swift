//
//  ArchivingQuestionItem.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/09.
//

import UIKit

struct ArchivingQuestionItem {
    let section: Int
    let questions: Questions
}

struct Questions {
    let id: Int
    let question: String
}

extension ArchivingQuestionItem {
    
    static func archivingQuestionDummy() -> [ArchivingQuestionItem] {
        return [
            ArchivingQuestionItem(section: 1, questions: Questions(id: 1, question: "할머니와 엄마의 꿈이 달랐어?")),
            ArchivingQuestionItem(section: 1, questions: Questions(id: 3, question: "할머니와 엄마의 꿈이 달랐어?"))
        ]
    }
}
