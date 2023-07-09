//
//  StringLiterals.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/03.
//

import Foundation

enum I18N {
    
    enum Common {
        static let nextButtonTitle = "다음으로"
    }
    
    enum Onboarding {
        static let test = "test"
        static let inviteNavigationTitle = "초대코드입력"
        static let inviteTitle = "초대코드를\n입력해주세요."
        static let inviteBoldTitle = "초대코드"
        static let inviteTextFieldPlaceholder = "초대코드를 입력해주세요."
        static let inviteError = "*올바른 초대코드 형식이 아닙니다."
        static let timeNotice = "매일 밤 11시에\n타임머신을 보내줄게"
        static let subNotice = "초대자가 선택한 시간에 따라 알림을 보내드립니다."
    }
    
    struct Auth {
        static let loginTitle = "부모와 떠나는 시간 여행"
        static let appleButtonTitle = "애플로 로그인"
        static let kakaoButtonTitle = "카카오로 로그인"
        static let entryButtonTitle = "시작하기"
        static let dividingText = "--------------------- or ---------------------"
        static let inviteText = "초대 코드를 받으셨나요?"
        static let inviteButtonTitle = "초대코드 입력하기"
    }
    
    struct Setting {
        static let settingTitle = "설정"
    }
    
}
