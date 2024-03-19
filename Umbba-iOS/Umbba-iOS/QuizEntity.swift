//
//  File.swift
//  Umbba-iOS
//
//  Created by 최영린 on 3/15/24.
//

import Foundation

struct QuizEntity: Codable {
    let closerQnaID, responseCase: Int?
    let balanceQuestion, choiceAnswer1, choiceAnswer2: String
    let myChoice, opponentChoice: String?

    enum CodingKeys: String, CodingKey {
        case closerQnaID = "closer_qna_id"
        case responseCase = "response_case"
        case balanceQuestion = "balance_question"
        case choiceAnswer1 = "choice_answer1"
        case choiceAnswer2 = "choice_answer2"
        case myChoice = "my_choice"
        case opponentChoice = "opponent_choice"
    }
}
