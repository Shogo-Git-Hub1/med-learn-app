import SwiftUI

struct ProfileView: View {
    private let user = AppUser.sample

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    profileHeader
                    statsSection
                    Spacer().frame(height: 60)
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
            }
            .background(AppTheme.bgMain.ignoresSafeArea())
            .navigationTitle("マイページ")
        }
    }

    private var profileHeader: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [AppTheme.primary, AppTheme.primaryDark],
                                        startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 80, height: 80)
                Text(String(user.displayName.prefix(1)))
                    .font(.system(size: 32, weight: .heavy))
                    .foregroundStyle(.white)
            }
            Text(user.displayName)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(AppTheme.textPrimary)
            Text(user.email)
                .font(.system(size: 14))
                .foregroundStyle(AppTheme.textSecondary)
            BadgeView(label: "Lv.\(user.level) インターン")
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(AppTheme.cardBg, in: RoundedRectangle(cornerRadius: 20))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(AppTheme.border, lineWidth: 1))
    }

    private var statsSection: some View {
        HStack(spacing: 12) {
            StatCardView(label: "連続学習",  value: "\(user.streakDays)日",
                         systemIcon: "flame.fill",     iconColor: Color(hex: "#F59E0B"))
            StatCardView(label: "正解率",    value: "\(Int(user.correctRate * 100))%",
                         systemIcon: "target",         iconColor: AppTheme.primary)
            StatCardView(label: "今週",      value: "\(user.weeklyCount)問",
                         systemIcon: "chart.bar.fill", iconColor: Color(hex: "#8B5CF6"))
        }
    }
}

#Preview {
    ProfileView()
}
