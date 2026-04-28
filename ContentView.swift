// 画面の土台（タブ切り替え+クイズ表示）
import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    @State private var quizSubject: Subject? = nil

    enum Tab { case home, courses, review, profile }

    var body: some View {
        ZStack(alignment: .bottom) {
            tabContent
            if quizSubject == nil {
                tabBar
            }
        }
        .fullScreenCover(item: $quizSubject) { subject in
            QuizView(subject: subject) { quizSubject = nil }
        }
        .ignoresSafeArea(edges: .bottom)
    }

    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case .home:
            HomeView { subject in quizSubject = subject }
        case .courses:
            CoursesView { subject in quizSubject = subject }
        case .review:
            ReviewView()
        case .profile:
            ProfileView()
        }
    }

    private var tabBar: some View {
        HStack(spacing: 0) {
            TabItemView(icon: "house.fill",    label: "ホーム",   tab: .home,    selected: selectedTab) { selectedTab = .home }
            TabItemView(icon: "book.fill",     label: "コース",   tab: .courses, selected: selectedTab) { selectedTab = .courses }
            TabItemView(icon: "arrow.clockwise", label: "復習",  tab: .review,  selected: selectedTab) { selectedTab = .review }
            TabItemView(icon: "person.fill",   label: "マイページ", tab: .profile, selected: selectedTab) { selectedTab = .profile }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
        .background(.regularMaterial, in: Capsule())
        .overlay(Capsule().stroke(.white.opacity(0.6), lineWidth: 1))
        .shadow(color: .black.opacity(0.12), radius: 20, y: 8)
        .padding(.horizontal, 16)
        .padding(.bottom, 28)
    }
}

struct TabItemView: View {
    let icon: String
    let label: String
    let tab: ContentView.Tab
    let selected: ContentView.Tab
    let action: () -> Void

    private var isActive: Bool { selected == tab }

    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: isActive ? .semibold : .regular))
                Text(label)
                    .font(.system(size: 10, weight: isActive ? .bold : .medium))
            }
            .foregroundStyle(isActive ? AppTheme.primary : Color(hex: "#475569"))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
            .background(
                isActive ? Color.white.opacity(0.95) : Color.clear,
                in: Capsule()
            )
            .shadow(color: isActive ? .black.opacity(0.08) : .clear, radius: 8, y: 2)
        }
        .buttonStyle(.plain)
    }
}

extension Subject: Swift.Identifiable {}

#Preview {
    ContentView()
}
