import Foundation

// Firebase Auth を追加後に実装を差し替える
@MainActor
class AuthService: ObservableObject {
    @Published var currentUser: AppUser? = AppUser.sample  // TODO: Firebase Auth に置き換え
    @Published var isSignedIn: Bool = true

    func signIn(email: String, password: String) async throws {
        // TODO: Auth.auth().signIn(withEmail:password:)
    }

    func signUp(email: String, password: String, name: String) async throws {
        // TODO: Auth.auth().createUser(withEmail:password:)
    }

    func signOut() throws {
        // TODO: try Auth.auth().signOut()
        currentUser = nil
        isSignedIn = false
    }
}
