import Foundation

enum QuestionType: String, Codable {
    case mcq       // 4択
    case trueFalse // ○×
    case fillBlank // 穴埋め
    case image     // 画像
}

struct Question: Identifiable, Codable {
    let id: String
    let subjectId: String
    let type: QuestionType
    let text: String
    let options: [String]
    let correctIndex: Int
    let explanation: String
    let imageURL: String?
    let blankAnswer: String?
}

extension Question {
    static let samples: [Question] = [
        Question(
            id: "q1", subjectId: "anatomy", type: .mcq,
            text: "心臓の左心室から血液が送り出される血管はどれか？",
            options: ["大動脈", "肺動脈", "大静脈", "肺静脈"],
            correctIndex: 0,
            explanation: "左心室から体循環へ血液を送り出す血管は大動脈です。",
            imageURL: nil, blankAnswer: nil
        ),
        Question(
            id: "q2", subjectId: "physiology", type: .trueFalse,
            text: "成熟した赤血球には核が存在する。",
            options: ["○ 正しい", "× 誤り"],
            correctIndex: 1,
            explanation: "成熟した赤血球には核がありません。分化の過程で脱核します。",
            imageURL: nil, blankAnswer: nil
        ),
    ]
}
