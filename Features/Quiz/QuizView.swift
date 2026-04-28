import SwiftUI

struct QuizView: View {
    let subject: Subject
    var onDismiss: (() -> Void)?

    @StateObject private var vm = QuizViewModel()

    var body: some View {
        ZStack {
            AppTheme.bgMain.ignoresSafeArea()
            if vm.isLoading {
                ProgressView()
            } else if vm.isFinished {
                resultView
            } else if let q = vm.currentQuestion {
                VStack(spacing: 0) {
                    quizHeader
                    questionCard(q)
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                    Spacer()
                    if vm.isAnswered { explanationCard(q) }
                    bottomButton
                }
            }
        }
        .task { await vm.load(subjectId: subject.id) }
    }

    // MARK: Header
    private var quizHeader: some View {
        VStack(spacing: 10) {
            HStack {
                Button(action: { onDismiss?() }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(AppTheme.textSecondary)
                        .frame(width: 36, height: 36)
                        .background(AppTheme.border.opacity(0.5), in: Circle())
                }
                Spacer()
                Text("\(vm.currentIndex + 1) / \(vm.questions.count)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(AppTheme.textSecondary)
                Spacer()
                BadgeView(label: subject.name,
                          textColor: subject.iconColor, bgColor: subject.bgColor)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(AppTheme.border)
                    Capsule()
                        .fill(AppTheme.primary)
                        .frame(width: geo.size.width * vm.progress)
                        .animation(.easeInOut(duration: 0.3), value: vm.progress)
                }
                .frame(height: 4)
            }
            .frame(height: 4)
            .padding(.horizontal, 16)
        }
    }

    // MARK: Question
    private func questionCard(_ q: Question) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(q.text)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(AppTheme.textPrimary)
                .lineSpacing(4)

            VStack(spacing: 10) {
                ForEach(q.options.indices, id: \.self) { i in
                    OptionButton(
                        text: q.options[i], index: i,
                        selected: vm.selectedIndex == i,
                        correct: vm.isAnswered ? i == q.correctIndex : nil,
                        action: { vm.select(i) }
                    )
                }
            }
        }
        .padding(20)
        .background(AppTheme.cardBg, in: RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.06), radius: 12, y: 4)
    }

    // MARK: Explanation
    private func explanationCard(_ q: Question) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: "lightbulb.fill")
                    .foregroundStyle(Color(hex: "#F59E0B"))
                Text("解説")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(AppTheme.textPrimary)
            }
            Text(q.explanation)
                .font(.system(size: 13))
                .foregroundStyle(AppTheme.textSecondary)
                .lineSpacing(4)
        }
        .padding(16)
        .background(Color(hex: "#FFFBEB"), in: RoundedRectangle(cornerRadius: 14))
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color(hex: "#FDE68A"), lineWidth: 1))
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.spring(duration: 0.3), value: vm.isAnswered)
    }

    // MARK: Bottom button
    private var bottomButton: some View {
        Button(action: vm.next) {
            Text(vm.currentIndex + 1 < vm.questions.count ? "次の問題" : "結果を見る")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(vm.isAnswered ? AppTheme.primary : AppTheme.border,
                            in: RoundedRectangle(cornerRadius: 16))
        }
        .disabled(!vm.isAnswered)
        .padding(.horizontal, 16)
        .padding(.bottom, 32)
    }

    // MARK: Result
    private var resultView: some View {
        VStack(spacing: 24) {
            Text("結果")
                .font(.system(size: 28, weight: .heavy))
                .foregroundStyle(AppTheme.textPrimary)
            Text("\(vm.correctCount) / \(vm.questions.count) 正解")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(AppTheme.primary)
            Button("もう一度") { vm.restart() }
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 40)
                .padding(.vertical, 14)
                .background(AppTheme.primary, in: RoundedRectangle(cornerRadius: 14))
        }
    }
}

struct OptionButton: View {
    let text: String
    let index: Int
    let selected: Bool
    let correct: Bool?
    let action: () -> Void

    private var bg: Color {
        guard let correct else { return selected ? AppTheme.lightBg : AppTheme.cardBg }
        if index == (correct == true ? index : -1) { return Color(hex: "#F0FDF4") }
        return selected ? Color(hex: "#FEF2F2") : AppTheme.cardBg
    }

    private var borderColor: Color {
        guard let correct else { return selected ? AppTheme.primary : AppTheme.border }
        if correct { return Color(hex: "#86EFAC") }
        return selected ? Color(hex: "#FCA5A5") : AppTheme.border
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text("\(["A","B","C","D"][safe: index] ?? "")")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(selected ? AppTheme.primary : AppTheme.textSecondary)
                    .frame(width: 28, height: 28)
                    .background(
                        selected ? AppTheme.midBlue : AppTheme.border.opacity(0.5),
                        in: Circle()
                    )
                Text(text)
                    .font(.system(size: 15))
                    .foregroundStyle(AppTheme.textPrimary)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(14)
            .background(bg, in: RoundedRectangle(cornerRadius: 14))
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(borderColor, lineWidth: 1.5))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    QuizView(subject: Subject.samples[0])
}
