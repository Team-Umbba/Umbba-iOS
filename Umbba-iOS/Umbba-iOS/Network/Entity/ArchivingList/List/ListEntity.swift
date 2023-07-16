//
//  ListEntity.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/16.
//

struct ListEntity: Codable {
    let qnaID: Int
    let index: Int
    let topic: String

    enum CodingKeys: String, CodingKey {
        case qnaID = "qna_id"
        case index, topic
    }
}
