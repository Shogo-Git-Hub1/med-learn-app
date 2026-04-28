import SwiftUI

struct CoursesView: View {
    @State private var subjects: [Subject] = Subject.samples
    var onStartQuiz: ((Subject) -> Void)?

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(subjects) { subject in
                        SubjectRowView(subject: subject) {
                            onStartQuiz?(subject)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 100)
            }
            .background(AppTheme.bgMain.ignoresSafeArea())
            .navigationTitle("コース")
        }
    }
}

struct SubjectRowView: View {
    let subject: Subject
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {
                Image(systemName: subject.systemIcon)
                    .font(.system(size: 22))
                    .foregroundStyle(subject.iconColor)
                    .frame(width: 52, height: 52)
                    .background(subject.bgColor, in: RoundedRectangle(cornerRadius: 14))

                VStack(alignment: .leading, spacing: 4) {
                    Text(subject.name)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(AppTheme.textPrimary)
                    Text("\(subject.questionCount)問収録")
                        .font(.system(size: 13))
                        .foregroundStyle(AppTheme.textSecondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(AppTheme.textSecondary.opacity(0.5))
            }
            .padding(16)
            .background(AppTheme.cardBg, in: RoundedRectangle(cornerRadius: 18))
            .overlay(RoundedRectangle(cornerRadius: 18).stroke(AppTheme.border, lineWidth: 1))
            .shadow(color: .black.opacity(0.04), radius: 4, y: 1)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CoursesView()
}
