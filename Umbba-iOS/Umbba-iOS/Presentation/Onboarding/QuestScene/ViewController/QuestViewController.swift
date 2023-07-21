//
//  QuestViewController.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/15.
//

import UIKit

struct QuestionModel: Hashable, Equatable {
    let number: Int // 문제 번호
    var answer: Int // 답변
    
    static func == (lhs: QuestionModel, rhs: QuestionModel) -> Bool {
        return lhs.number == rhs.number
    }
}

final class QuestViewController: UIViewController {
    
    // MARK: - Properties
    
    var isReceiver: Bool = false
    var currentAnswer: Int = -1
    var answerArray: [QuestionModel] = (0...4).map {
        .init(number: $0, answer: -1)
    }
    var answerListArray: [String] = []
    
    // MARK: - UI Components
    
    private let questView = QuestView()
    private lazy var questCollectionView = questView.questCollectionView
    private lazy var progressView = questView.progressView
    private lazy var nextButton = questView.nextButton
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = questView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        registerCell()
    }
}

// MARK: - Extensions

private extension QuestViewController {
    
    func setDelegate() {
        questView.navigationdelegate = self
        questView.nextDelegate = self
        questCollectionView.delegate = self
        questCollectionView.dataSource = self
    }
    
    func registerCell() {
        QuestCollectionViewCell.register(target: questCollectionView)
    }
    
    func convertToAnswerArray(questionModels: [QuestionModel]) -> [String] {
        let answerArray = questionModels.map { $0.answer }

        let convertedArray = answerArray.map { answer -> String in
            switch answer {
            case 0:
                return "응"
            case 1:
                return "아니"
            case 2:
                return "애매해"
            default:
                return ""
            }
        }

        return convertedArray
    }
}

extension QuestViewController: NavigationBarDelegate {
    
    private func hasAnswer(_ number: Int) {
        if answerArray[number].answer != -1 {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    
    func backButtonTapped() {
        guard let currentIndexPath = questCollectionView.indexPathsForVisibleItems.first else { return }
        if currentIndexPath.item == 0 {
            self.navigationController?.popViewController(animated: true)
        } else {
            progressView.progress = Float(currentIndexPath.item) * 0.2
            let previousIndexPath = IndexPath(item: currentIndexPath.item - 1, section: currentIndexPath.section)
            questCollectionView.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
            let index = currentIndexPath.item - 1
            hasAnswer(index)
        }
    }
    
    func completeButtonTapped() {
        
    }
}

extension QuestViewController: NextButtonDelegate {
    func nextButtonTapped() {
        guard let currentIndexPath = questCollectionView.indexPathsForVisibleItems.first else { return }
        
        if currentIndexPath.item + 1 == 5 {
            answerListArray = convertToAnswerArray(questionModels: answerArray)
            UserData.shared.onboardingAnswerList = answerListArray
            if isReceiver {
                UserManager.shared.updateUserName( UserData.shared.userInfo.name)
                self.patchReceiveAPI(user_info: UserData.shared.userInfo,
                                     onboarding_answer_list: UserData.shared.onboardingAnswerList)
            } else {
                let pushAlarmViewController = PushAlarmViewController()
                pushAlarmViewController.isReceiver = self.isReceiver
                self.navigationController?.pushViewController(pushAlarmViewController, animated: true)
            }
        } else {
            let index = currentIndexPath.item
            hasAnswer(index + 1)
            progressView.progress = Float(currentIndexPath.item + 2) * 0.2
            let nextIndexPath = IndexPath(item: currentIndexPath.item + 1, section: currentIndexPath.section)
            questCollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension QuestViewController: UICollectionViewDelegate {
    
}

extension QuestViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = QuestCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        cell.questionLabel.text = I18N.Onboarding.questionArray[indexPath.item]
        cell.questDelegate = self
        cell.questionIndex = indexPath.item
        
        cell.yesButton.isSelected = false
        cell.noButton.isSelected = false
        cell.skipButton.isSelected = false

        let answer = answerArray[indexPath.item].answer
        if answer >= 0 {
            cell.answerIndex = answer
            nextButton.isEnabled = true
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}

extension QuestViewController: QuestDelegte {
    func selectAnswer(_ cell: QuestCollectionViewCell, questionIndex: Int, answerIndex: Int) {
        currentAnswer = answerIndex
        answerArray[questionIndex].answer = currentAnswer
        nextButton.isEnabled = true
    }
}

// MARK: - Network

extension QuestViewController {
    func patchReceiveAPI(user_info: User,
                         onboarding_answer_list: [String]) {
        OnBoardingService.shared.patchRecieveAPI(user_Info: user_info,
                                                 onboarding_answer_list: onboarding_answer_list) { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                if let data = data as? GenericResponse<ReceiveEntity> {
                    let noticeAlarmViewController = NoticeAlarmViewController()
                    noticeAlarmViewController.isReceiver = self.isReceiver
                    noticeAlarmViewController.pushTime = data.data?.pushTime ?? ""
                    self.navigationController?.pushViewController(noticeAlarmViewController, animated: true)
                }
            case .requestErr, .serverErr:
                self.makeAlert(title: "오류가 발생했습니다", message: "다시 시도해주세요")
            default:
                break
            }
        }
    }
}
