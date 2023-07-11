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
        static let userInfoTitle = "반가워!\n너에 대행 알고 싶어!"
        static let nameInfo = "너의 이름이 뭐야?"
        static let namePlaceholder = "이름을 입력해주세요."
        static let nameError = "*올바른 형식이 아닙니다."
        static let genderInfo = "너의 성별을 알려줘!"
        static let male = "남자"
        static let female = "여자"
        static let birthInfo = "태어난 연도는 언제야?"
        static let birthPlaceholder = "태어난 연도를 입력해주세요."
        static let birthError = "*올바른 형식이 아닙니다."
        static let familyInfoTitle = "오늘부터 매일,\n과거로 시간여행을 떠날거야"
        static let relationInfo = "누구와 함께하겠어??"
        static let parent = "부모님"
        static let child = "자식"
        static let detailnfo = "더 자세히 알려줄 수 있어?"
        static let mom = "엄마"
        static let dad = "아빠"
        static let daughter = "딸"
        static let son = "아들"
        static let pushAlarmTitle = "매일 밤\n교신을 보내줄게"
        static let pushAlarmDescription = "선택한 시간에 따라 푸시 알림을 보내드립니다"
        static let time = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
        static let minute = ["00", "30"]
        static let am = ["AM", "PM"]
        static let completeTitle = "과거에 도착했어!\n앞으로 나눌 이야기가 많을거야"
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

    enum Archiving {
        static let navigationTitle = "리스트"
        static let sectionArray = ["어린 시절", "학창 시절", "청춘 시절", "연애 시절", "우리가 만나고"]
    }
    
    enum Write {
        static let navigationTitle = "어린시절"
        static let numberTitle = "#1"
        static let themeTitle = "가장 오래된 기억"
        static let questionTitle = "당신과 어머니의 꿈은 달라?"
        static let answerPlaceholder = "답변을 입력해주세요"
        static let countText = "(0/100)"
    }
    
    enum Setting {
        static let settingTitle = "설정"
        static let settingLabel = "알람 설정"
        static let userSectionLabel = ["계정 관리"]
        static let teamSectionLabel = ["About 엄빠도 어렸다", "이용약관", "공지사항"]
    }
    
    enum Alert {
        static let inviteTitle = "상대를 초대할 차례야\n상대방이 수락하면 문답이 시작돼"
        static let copyButtonTitle = "초대코드 복사"
        static let inviteCode = "1234-1234556"
        static let shateButtonTitle = "초대장 보내기"
        static let writeCancelTitle = "답변 작성을 취소하시겠어요?\n작성 중인 답변은 저장되지 않아요"
        static let withdrawalTitle = "정말 회원을 탈퇴하시겠습니까?"
        static let cancelButtonTitle = "취소"
        static let confirmButtonTitle = "확인"
        static let writeSaveTitle = "답변을 저장하시겠어요?"
        static let backButtonTitle = "돌아가기"
        static let saveButtonTitle = "저장"
    }
}
