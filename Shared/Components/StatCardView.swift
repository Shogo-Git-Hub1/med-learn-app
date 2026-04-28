import SwiftUI

struct StatCardView: View {
    let label: String
    let value: String
    let systemIcon: String
    let iconColor: Color

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: systemIcon)
                .font(.system(size: 18))
                .foregroundStyle(iconColor)
            Text(value)
                .font(.system(size: 16, weight: .heavy))
                .foregroundStyle(AppTheme.textPrimary)
            Text(label)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(AppTheme.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 10)
        .background(AppTheme.cardBg, in: RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(AppTheme.border, lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.05), radius: 4, y: 1)
    }
}
