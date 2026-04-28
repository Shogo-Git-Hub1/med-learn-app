import SwiftUI

struct Subject: Identifiable, Codable {
    let id: String
    let name: String
    let systemIcon: String
    let iconColorHex: String
    let bgColorHex: String
    let questionCount: Int

    var iconColor: Color { Color(hex: iconColorHex) }
    var bgColor: Color   { Color(hex: bgColorHex) }
}

extension Subject {
    static let samples: [Subject] = [
        Subject(id: "anatomy",     name: "解剖学", systemIcon: "heart.fill",       iconColorHex: "#DC2626", bgColorHex: "#EFF6FF", questionCount: 128),
        Subject(id: "physiology",  name: "生理学", systemIcon: "bolt.fill",        iconColorHex: "#10B981", bgColorHex: "#F0FDF4", questionCount: 96),
        Subject(id: "pharmacology",name: "薬理学", systemIcon: "pill.fill",        iconColorHex: "#EA580C", bgColorHex: "#FFF7ED", questionCount: 84),
        Subject(id: "pathology",   name: "病理学", systemIcon: "microbe.fill",     iconColorHex: "#7C3AED", bgColorHex: "#FDF4FF", questionCount: 72),
    ]
}
