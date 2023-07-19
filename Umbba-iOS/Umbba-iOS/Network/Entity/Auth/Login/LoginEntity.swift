//
//  LoginEntity.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/18.
//

struct LoginEntity: Codable {
    let userID: Int
    let isMatchFinish: Bool
    let username: String?
    let gender: String?
    let bornYear: Int?
    let tokenDto: TokenDto
    let fcmToken, socialPlatform, socialNickname: String
    let socialProfileImage: String?
    let socialAccessToken: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case isMatchFinish = "is_match_finish"
        case username, gender
        case bornYear = "born_year"
        case tokenDto = "token_dto"
        case fcmToken = "fcm_token"
        case socialPlatform = "social_platform"
        case socialNickname = "social_nickname"
        case socialProfileImage = "social_profile_image"
        case socialAccessToken = "social_access_token"
    }
}

// MARK: - TokenDto
struct TokenDto: Codable {
    let accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
