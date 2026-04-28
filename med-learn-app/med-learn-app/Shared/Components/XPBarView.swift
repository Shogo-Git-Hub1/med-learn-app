import SwiftUI

struct XPBarView: View {
    let xp: Int
    let maxXp: Int

    private var progress: Double { min(1.0, Double(xp) / Double(maxXp)) }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.white.opacity(0.2))
                    .frame(height: 8)
                Capsule()
                    .fill(LinearGradient(
                        colors: [AppTheme.primary, AppTheme.accent],
                        startPoint: .leading, endPoint: .trailing
                    ))
                    .frame(width: geo.size.width * progress, height: 8)
                    .animation(.easeInOut(duration: 0.6), value: progress)
            }
        }
        .frame(height: 8)
    }
}
