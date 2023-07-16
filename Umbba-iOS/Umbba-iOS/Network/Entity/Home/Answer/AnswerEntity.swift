//
//  AnswerEntity.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/16.
//

import Foundation

struct AnswerEntity: Codable {
    let qnaID: Int
    let section, topic, opponentQuestion, myQuestion: String?
    let opponentAnswer: String?
    let myAnswer: String?
    let isOpponentAnswer, isMyAnswer: Bool
    let opponentUsername, myUsername: String?

    enum CodingKeys: String, CodingKey {
        case qnaID = "qna_id"
        case section, topic
        case opponentQuestion = "opponent_question"
        case myQuestion = "my_question"
        case opponentAnswer = "opponent_answer"
        case myAnswer = "my_answer"
        case isOpponentAnswer = "is_opponent_answer"
        case isMyAnswer = "is_my_answer"
        case opponentUsername = "opponent_username"
        case myUsername = "my_username"
    }
}
