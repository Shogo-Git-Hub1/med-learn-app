import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var user: AppUser = AppUser.sample
    @Published var subjects: [Subject] = Subject.samples
    @Published var isLoading = false

    private let quizService = QuizService()

    func load() async {
        isLoading = true
        defer { isLoading = false }
        do {
            subjects = try await quizService.fetchSubjects()
        } catch {
            print("HomeViewModel load error: \(error)")
        }
    }
}
