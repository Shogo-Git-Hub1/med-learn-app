import Foundation

struct AppUser: Codable {
    let uid: String
    var displayName: String
    var email: String
    var level: Int
    var xp: Int
    var maxXp: Int
    var streakDays: Int
    var correctRate: Double
    var weeklyCount: Int

    static let empty = AppUser(
        uid: "", displayName: "ゲスト", email: "",
        level: 1, xp: 0, maxXp: 100,
        streakDays: 0, correctRate: 0, weeklyCount: 0
    )

    static let sample = AppUser(
        uid: "sample", displayName: "中医 太郎", email: "taro@example.com",
        level: 7, xp: 340, maxXp: 500,
        streakDays: 5, correctRate: 0.78, weeklyCount: 42
    )
}
