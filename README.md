## 🙌 Team Umbba-iOS
### 👩‍👩‍👧‍👦 About Umbba  
> **부모의 추억을 자식과 공유하며 공감대를 찾는 문답형 아카이빙 서비스, 엄빠도 어렸다 👨‍👩‍👧‍👦**


### 👩‍💻 About Developers
> **우리도 어렸다 👶🏻**

| [최영린](https://github.com/joeuni01) | [고아라](https://github.com/ahra1221) | [남유진](https://github.com/yujin-00)|
| --- | --- | --- |
| <img src = "https://github.com/Team-Umbba/Umbba-iOS/assets/79412889/7643c0b4-9526-4ab0-8d22-f9cfbbd8e2a1" width = "300">| <img src = "https://github.com/Team-Umbba/Umbba-iOS/assets/79412889/7f981eb3-a94c-41e1-aab9-6f995a53e26b" width = "300"> | <img src = "https://github.com/Team-Umbba/Umbba-iOS/assets/79412889/16a78f30-9a22-4d36-9e50-b4fbbca5ea5e" width = "300"> |
|<p align = "center">`온보딩` `답변작성` `팝업뷰`|<p align = "center">`소셜로그인` `메인뷰`  `아카이빙뷰` |<p align = "center">`답변상세뷰` `설정뷰` `계정관리뷰`|

### 📒 Library
| Library | Tag | Tool |
| --- | --- | --- |
| SnapKit | Layout | SPM |
| Alamofire | Network | SPM |
| FireBase | PushAlarm | SPM 
| KaKaoOpenSDK | SocialLogin, Share | SPM |
| Lottie | Splash, Animation | SPM |

### 💬 Code Convention
✅ [Code Convention](https://harsh-step-7dd.notion.site/Code-Convention-0e11217167a448fabeb9b0d556c4d06f?pvs=4)

### 🌳 Git Flow : Forking Flow
✅ [Git Flow](https://harsh-step-7dd.notion.site/Git-Branch-b241eb872aaf4c9cb22cdf78d46c659d?pvs=4)


### 📁 Foldering

```
├── 📁 Application
│   ├── 🗂️ Manager
│   ├── Appdelegate
│   ├── SceneDelegate
├── 📁 Global
│   ├── 🗂️ Resources
│   │   ├── 🗂️ Lottie
│   │   ├── 🗂️ Font
│   │   ├── Assets
│   ├── 🗂️ Extension
│   ├── 🗂️ Literals
│   ├── 🗂️ Protocols
│   ├── 🗂️ Utils
│   ├── 🗂️ Supporting Files
│   │   ├── LaunchScreen
├── 📁 Network
│   ├── 🗂️ Environment
│   ├── 🗂️ Base
│   ├── 🗂️ Entity
│   ├── 🗂️ Services
├── 📁 Presentation
│   ├── 🗂️ Common
│   ├── 🗂️ Home
│   │   │   ├── 🗂️ MainScene
│   │   │   │   ├── 🗂️ ViewController
│   │   │   │   ├── 🗂️ View
├───├───├───├───├── 🗂️ Cells
├── Info.plist
├── .swiftlint

```

### 👩🏻‍🎨 View Sketch
✅ [View Sketch](https://snapdragon-desk-8fd.notion.site/View-c95f9f2e3d2a442fba1e3eccb65d4afa?pvs=4)


### 🔥 TroubleShooting
✅ [TroubleShooting 모음집](https://snapdragon-desk-8fd.notion.site/a58e6c5fe2a643048b80781d80ae5fc8)

<details>
  <summary>🐥 최영린</summary>
저희 서비스는 첫 화면이 아닌 특정 화면에서 푸시알림 창을 띄워야 했기 때문에 이것을 해결하는 것에서 많은 고민을 했습니다. 해결하는 과정에서 깨달은 점은 FCMToken이 두번 발급되지 않으려면 UIApplication.shared.registerForRemoteNotifications()를 호출해주는 시점을 특정 화면에서 조절하는 것이 가장 중요하다는 것이었습니다.
</details>

<details>
  <summary>🐰 고아라</summary>
  '엄빠도 어렸다'에서 맡은 기능 중 제일 많은 시간을 투자 했던 부분은 소셜 로그인 구현이었습니다. 소셜 로그인도 어려웠지만 그때 사용자 정보를 저장하여 앱을 종료 후에 재 실행 했을 때 자동으로 메인 화면으로 넘어가게 하는 부분에서 어려움을 겪었습니다. iOS에서 기본으로 제공하고 있는 UserDefault를 사용한 UserManager 클래스를 구현해 자동 로그인 시 필요한 정보를 회원가입 시에 저장하는 방식으로 해결했습니다!
</details>

<details>
  <summary>🦖 남유진</summary>
앱잼 기간 내에 기능적인 측면에서 가장 많은 고민을 했던 트러블은 푸쉬알림 권한 설정을 스위치에 적용하는 것이었습니다. 권한 설정 창에 들어간 후 권한 허용을 변경하지 않은 경우에 스위치 상태를 그대로 유지하도록 구현하는 것이 문제였습니다. UserManager에서 알림 허용 여부를 확인하고 NotificationCenter를 사용하여 알림을 관찰하고 그에 따라 UI 업데이트를 해주었습니다.
</details>
