import Foundation

// Firebase Firestore を追加後に実装を差し替える
class QuizService {
    func fetchSubjects() async throws -> [Subject] {
        // TODO: Firestore から取得
        return Subject.samples
    }

    func fetchQuestions(subjectId: String) async throws -> [Question] {
        // TODO: Firestore から取得
        return Question.samples.filter { $0.subjectId == subjectId }
    }

    func submitAnswer(questionId: String, selectedIndex: Int, userId: String) async throws {
        // TODO: Firestore に回答記録を保存
    }
}
