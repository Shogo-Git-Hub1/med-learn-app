// アプリの入り口
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

@main //iosアプリのスタート地点、「ここからアプリ開始」の印
struct med_learn_appApp: App { // med_learn_appAppという名前の構造体が作られ、Appプロトコルをに準拠することを示す。
    // @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene { //bodyはAppプロトコルで必須、SceneはSwiftUIでの画面の入れ物（表示単位）で、アプリがユーザーに見せる1セットのUI環境
        WindowGroup { //WindowGroupは1つのウィンドウに複数の画面を配置するためのコンテナ
            ContentView() //ContentViewを表示
        }
    }
}
