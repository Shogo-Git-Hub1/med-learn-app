import Foundation

@MainActor
class QuizViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentIndex: Int = 0
    @Published var selectedIndex: Int? = nil
    @Published var isAnswered: Bool = false
    @Published var isFinished: Bool = false
    @Published var correctCount: Int = 0
    @Published var isLoading = false

    private let quizService = QuizService()

    var currentQuestion: Question? { questions[safe: currentIndex] }
    var progress: Double { questions.isEmpty ? 0 : Double(currentIndex) / Double(questions.count) }

    func load(subjectId: String) async {
        isLoading = true
        defer { isLoading = false }
        do {
            questions = try await quizService.fetchQuestions(subjectId: subjectId)
        } catch {
            print("QuizViewModel load error: \(error)")
        }
    }

    func select(_ index: Int) {
        guard !isAnswered else { return }
        selectedIndex = index
        isAnswered = true
        if index == currentQuestion?.correctIndex {
            correctCount += 1
        }
    }

    func next() {
        if currentIndex + 1 < questions.count {
            currentIndex += 1
            selectedIndex = nil
            isAnswered = false
        } else {
            isFinished = true
        }
    }

    func restart() {
        currentIndex = 0
        selectedIndex = nil
        isAnswered = false
        isFinished = false
        correctCount = 0
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
