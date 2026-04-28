import SwiftUI

// Firebase SDK を追加後:
// import FirebaseCore
// class AppDelegate: NSObject, UIApplicationDelegate {
//     func application(_ application: UIApplication,
//                      didFinishLaunchingWithOptions ...) -> Bool {
//         FirebaseApp.configure()
//         return true
//     }
// }

@main
struct med_learn_appApp: App {
    // @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
