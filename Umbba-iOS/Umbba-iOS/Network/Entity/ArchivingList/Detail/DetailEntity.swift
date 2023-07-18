//
//  DetailEntity.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/18.
//

struct DetailEntity: Codable {
    let qnaID, index: Int
    let section, topic, opponentQuestion, myQuestion: String?
    let opponentAnswer, myAnswer, opponentUsername, myUsername: String?

    enum CodingKeys: String, CodingKey {
        case qnaID = "qna_id"
        case index, section, topic
        case opponentQuestion = "opponent_question"
        case myQuestion = "my_question"
        case opponentAnswer = "opponent_answer"
        case myAnswer = "my_answer"
        case opponentUsername = "opponent_username"
        case myUsername = "my_username"
    }
}
