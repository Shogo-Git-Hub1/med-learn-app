import SwiftUI

struct ReviewView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                Image(systemName: "arrow.clockwise.circle.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(AppTheme.primary)
                Text("復習機能は準備中です")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(AppTheme.textPrimary)
                Text("間違えた問題や苦手な問題を\nまとめて復習できるようになります。")
                    .font(.system(size: 14))
                    .foregroundStyle(AppTheme.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                Spacer()
            }
            .padding(.bottom, 100)
            .background(AppTheme.bgMain.ignoresSafeArea())
            .navigationTitle("復習")
        }
    }
}

#Preview {
    ReviewView()
}
