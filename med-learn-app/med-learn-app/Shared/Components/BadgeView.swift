import SwiftUI

struct BadgeView: View {
    let label: String
    var textColor: Color = AppTheme.primaryDark
    var bgColor: Color   = AppTheme.midBlue

    var body: some View {
        Text(label)
            .font(.system(size: 11, weight: .bold))
            .foregroundStyle(textColor)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(bgColor, in: Capsule())
    }
}
