//
//  MyPageEntity.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2/25/24.
//

struct MyPageEntity: Codable {
    let myUsername, myUserType, opponentUserType: String
    let opponentUsername: String?
    let parentchildRelation: String
    let isMeChild: Bool
    let section: String
    let matchedDate, qnaCnt: Int
    let inviteCode: String
    let installURL: String

    enum CodingKeys: String, CodingKey {
        case myUsername = "my_username"
        case myUserType = "my_user_type"
        case opponentUsername = "opponent_username"
        case opponentUserType = "opponent_user_type"
        case parentchildRelation = "parentchild_relation"
        case isMeChild = "is_me_child"
        case section
        case matchedDate = "matched_date"
        case qnaCnt = "qna_cnt"
        case inviteCode = "invite_code"
        case installURL = "install_url"
    }
}
