import SwiftUI

struct AppTheme {
    static let primary    = Color(hex: "#2563EB")
    static let primaryDark = Color(hex: "#1E40AF")
    static let accent     = Color(hex: "#10B981")
    static let lightBg    = Color(hex: "#EFF6FF")
    static let midBlue    = Color(hex: "#BFDBFE")
    static let bgMain     = Color(hex: "#F8FAFF")
    static let textPrimary = Color(hex: "#111827")
    static let textSecondary = Color(hex: "#6B7280")
    static let cardBg     = Color.white
    static let border     = Color(hex: "#E5E7EB")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8)  & 0xFF) / 255
        let b = Double(int & 0xFF)         / 255
        self.init(red: r, green: g, blue: b)
    }
}
