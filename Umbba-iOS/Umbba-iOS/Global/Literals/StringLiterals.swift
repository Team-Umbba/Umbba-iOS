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
        static let inviteNavigationTitle = "초대코드 입력"
        static let inviteTitle = "초대코드를 입력해줘"
        static let inviteBoldTitle = "초대코드"
        static let inviteTextFieldPlaceholder = "ex) ORWO-11yzwx"
        static let inviteError = "*올바른 초대코드 형식이 아닙니다"
        static let timeExplain = "오늘부터 매일,\n과거로 시간 여행을 떠날 거야"
        static let pastBold = "과거"
        static let timeNotice = "매일 밤 11시에\n교신을 보내줄게"
        static let subNotice = "초대자가 선택한 시간에 따라 푸시 알림을 보내드려요"
        static let userInfoTitle = "반가워!\n너에 대해 알고 싶어"
        static let nameInfo = "너의 이름이 뭐야?"
        static let namePlaceholder = "ex) 홍길동"
        static let nameError = "*올바른 형식이 아닙니다"
        static let genderInfo = "너의 성별을 알려줘!"
        static let male = "남자"
        static let female = "여자"
        static let birthInfo = "태어난 연도는 언제야?"
        static let birthPlaceholder = "ex) 1988"
        static let birthError = "*올바른 형식이 아닙니다."
        static let familyInfoTitle = "오늘부터 매일\n과거로 시간여행을 떠날거야"
        static let relationInfo = "누구와 함께 하겠어?"
        static let parent = "부모님"
        static let child = "자식"
        static let detailnfo = "더 자세히 알려줄 수 있어?"
        static let mom = "엄마"
        static let dad = "아빠"
        static let daughter = "딸"
        static let son = "아들"
        static let questionArray = [" 지금 가족과 함께 살고 있어?", "고등학교를 졸업했어?", "결혼을 꼭 해야 한다고 생각해?", "뭔가를 크게 포기해본 경험이 있어?", "돌아가고 싶은 순간이 있어?"]
        static let pushAlarmTitle = "매일 너에게\n교신을 보내줄게"
        static let pushAlarmDescription = "선택한 시간에 따라 푸시 알림을 보내드려요"
        static let time = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
        static let minute = ["00", "30"]
        static let am = ["AM", "PM"]
        static let completeTitle = "과거에 도착했어!\n앞으로 나눌 이야기가 많을 거야"
        static let animationLabel = "오래된 공중전화에서 수신음이 들린다"
        static let callingButton = "전화 받기"
        static let completeButton = "시작하기"
    }
    
    enum Auth {
        static let loginTitle = "부모와 떠나는 시간 여행"
        static let appleButtonTitle = "애플로 연동하기"
        static let kakaoButtonTitle = "카카오로 연동하기"
        static let entryButtonTitle = "시작하기"
        static let dividingText = "--------------------- or ---------------------"
        static let inviteText = "카카오톡 초대 코드를 받고 왔어요"
        static let inviteButtonTitle = "초대코드로 시작하기"
        static let logoTitle = "엄빠도 어렸다"
        static let logoSubTitle = "처음부터 다시 나누는 이야기"
        static let assignEntireTitle = "전체 동의하기"
        static let assignEntireSubTitle = "본인은 만 14세 이상이며, 엄빠도 어렸다 서비스 이용약관, 개인정보 수집 및 이용에 모두 동의합니다."
        static let assignFirstTitle = "[필수] 만 14세 이상입니다."
        static let assignFirstSubTitle = "엄빠도 어렸다 서비스를 이용하기 위해서는 만 14세 이상이 되어야 합니다. 만 14세 미만의 이용자의 경우 서비스의 이용이 제한됩니다."
        static let assignSecondTitle = "[필수] 서비스 이용약관에 동의합니다."
        static let assignThirdTitle = "[필수] 개인정보 수집 및 이용에 동의합니다."
        static let assignThirdSubTitle = "\'(주)이승준 컴퍼니\'(이하 \'회사\')가 운영하는 \'엄빠도 어렸다\'는 개인정보보호법 제 30조 의거 이용자의 개인정보보호와 권익을 보호하고 관련된 고충 및 애로사항을 신속하게 처리하기 위해 아래의 개인정보처리방침을 제정·운영하고 있습니다."
        static let assignNextButtonTitle = "다음으로"
        static let kakaoFailMessage = "카카오톡 로그인에 실패하였습니다."
    }

    enum Archiving {
        static let navigationTitle = "리스트"
        static let sectionArray = ["어린시절", "학창시절", "청춘시절", "연애시절", "우리가 만나고"]
    }
    
    enum Write {
        static let navigationTitle = "어린시절"
        static let numberTitle = "#1"
        static let themeTitle = "가장 오래된 기억"
        static let questionTitle = "당신과 어머니의 꿈은 달라?\n당신과 어머니의 꿈으 ㄴ다라다라라라"
        static let answerPlaceholder = "답변을 입력해주세요"
        static let countText = "(0/100)"
    }
    
    enum Detail {
        static let navigationTitle = "어린시절"
        static let numberTitle = "#1"
        static let themeTitle = "가장 오래된 기억"
        static let partnerQuestLabel = "할머니와 엄마의 꿈이 달랐어?"
        static let myQuestLabel = "당신과 어머니의 꿈은 달라?"
        static let answerButton = "답변하기"
        static let homeButton = "홈으로"
        static let partnerName = "이승준."
        static let myName = "김수연."
        static let noneAnswer = "상대방은 아직 답변하지 않았어요"
        static let pleaseAnswer = "하단버튼을 눌러 답변을 입력하세요"
    }
    
    enum Setting {
        static let settingTitle = "설정"
        static let settingLabel = "알람 설정"
        static let settingNavigationTitle = "설정"
        static let accountNavigationTitle = "계정 관리"
        static let userSectionLabel = ["계정 관리"]
        static let teamSectionLabel = ["About 엄빠도 어렸다", "이용약관", "개인정보 처리방침"]
        static let accountSectionLabel = ["로그아웃", "회원 탈퇴"]
        static let urlArray = ["https://brawny-guan-098.notion.site/7b3e5f70a471468f8acbe56a1a4f4ec9",
                               "https://harsh-step-7dd.notion.site/f1a14bf60ed4421f9b3761ef88906adb",
                               "https://harsh-step-7dd.notion.site/99fe0f58825d4f87bd3b987fadc623b6?pvs=4"]
        static let cancelNavigatonTitle = "회원 탈퇴"
        static let quoteLabel = "\"추억은 일종의 만남이다.\""
        static let personLabel = "- 칼린 지브란 -"
        static let withdrawalQuestLabel = "회원 탈퇴를 진행하시겠습니까?"
        static let withdrawalContentLabel = "작성한 모든 문답 내역이 삭제되며 상대측에게는 더 이상 알림이 가지않습니다. 삭제한 내역은 복구할 수 없으니 신중하게 선택해주세요."
        static let withdrawalButton = "탈퇴하기"
    }
    
    enum Alert {
        static let inviteTitle = "상대를 초대할 차례야\n상대방이 수락하면 문답이 시작돼"
        static let copyButtonTitle = "초대코드 복사"
        static let inviteCode = "1234-1234556"
        static let shateButtonTitle = "카카오톡으로 초대 보내기"
        static let writeCancelTitle = "답변 작성을 취소하시겠어요?\n작성 중인 답변은 저장되지 않아요"
        static let withdrawalTitle = "정말 회원을 탈퇴하시겠습니까?"
        static let cancelButtonTitle = "취소"
        static let confirmButtonTitle = "확인"
        static let writeSaveTitle = "답변을 저장하시겠어요?"
        static let backButtonTitle = "돌아가기"
        static let saveButtonTitle = "저장"
        static let disconnectTitle = "상대와의 연결이 끊어졌어요"
        static let disconnectDiscription = "새로운 상대와 함께 하려면\n회원 탈퇴 후 이용해주세요"
    }
    
    enum Lottie {
        static let lottieName = "splash_iOS"
    }
    
    enum Home {
        static let questionButtonTitle = "질문 확인하기"
    }
}
