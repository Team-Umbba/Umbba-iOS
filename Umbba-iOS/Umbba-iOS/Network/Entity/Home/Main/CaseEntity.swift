//
//  CaseEntity.swift
//  Umbba-iOS
//
//  Created by 남유진 on 2023/07/16.
//

struct CaseEntity: Codable {
    let responseCase: Int?
    let inviteCode, inviteUsername, installURL: String?
    let relativeUserActivate: Bool?

    enum CodingKeys: String, CodingKey {
        case responseCase = "response_case"
        case inviteCode = "invite_code"
        case inviteUsername = "invite_username"
        case installURL = "install_url"
        case relativeUserActivate = "relative_user_activate"
    }
}
