import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    var onStartQuiz: ((Subject) -> Void)?

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                heroHeader
                VStack(spacing: 20) {
                    statsRow
                    dailyChallenge
                    subjectSection
                }
                .padding(.horizontal, 16)
                .padding(.top, 18)
                .padding(.bottom, 100)
            }
        }
        .background(AppTheme.bgMain.ignoresSafeArea())
        .task { await vm.load() }
    }

    // MARK: Hero
    private var heroHeader: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [AppTheme.primary, AppTheme.primaryDark],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .frame(height: 260)

            // Decorative circles
            Circle().fill(.white.opacity(0.06))
                .frame(width: 150).offset(x: 80, y: -80)
            Circle().fill(.white.opacity(0.04))
                .frame(width: 120).offset(x: -70, y: 30)

            VStack(alignment: .leading, spacing: 0) {
                Text("おはようございます")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white.opacity(0.75))
                    .padding(.bottom, 4)
                Text("今日も学習を\n続けましょう！")
                    .font(.system(size: 22, weight: .heavy))
                    .foregroundStyle(.white)
                    .lineSpacing(4)
                    .padding(.bottom, 16)

                levelCard
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.bottom, 28)
        }
    }

    private var levelCard: some View {
        VStack(spacing: 8) {
            HStack {
                HStack(spacing: 8) {
                    Text("\(vm.user.level)")
                        .font(.system(size: 13, weight: .heavy))
                        .foregroundStyle(.white)
                        .frame(width: 28, height: 28)
                        .background(AppTheme.accent, in: RoundedRectangle(cornerRadius: 10))
                    Text("Lv.\(vm.user.level) インターン")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.white)
                }
                Spacer()
                Text("\(vm.user.xp) / \(vm.user.maxXp) XP")
                    .font(.system(size: 12))
                    .foregroundStyle(.white.opacity(0.7))
            }
            XPBarView(xp: vm.user.xp, maxXp: vm.user.maxXp)
        }
        .padding(16)
        .background(.white.opacity(0.12), in: RoundedRectangle(cornerRadius: 16))
    }

    // MARK: Stats
    private var statsRow: some View {
        HStack(spacing: 10) {
            StatCardView(label: "連続学習",  value: "\(vm.user.streakDays)日",
                         systemIcon: "flame.fill",       iconColor: Color(hex: "#F59E0B"))
            StatCardView(label: "正解率",    value: "\(Int(vm.user.correctRate * 100))%",
                         systemIcon: "target",           iconColor: AppTheme.primary)
            StatCardView(label: "今週",      value: "\(vm.user.weeklyCount)問",
                         systemIcon: "chart.bar.fill",   iconColor: Color(hex: "#8B5CF6"))
        }
    }

    // MARK: Daily challenge
    private var dailyChallenge: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "bolt.fill")
                    .foregroundStyle(AppTheme.primary)
                Text("デイリーチャレンジ")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(AppTheme.textPrimary)
                Spacer()
                BadgeView(label: "+5 XP")
            }
            Text("本日のテーマ：循環器系の解剖学\n10問に挑戦して報酬を獲得しよう！")
                .font(.system(size: 13))
                .foregroundStyle(AppTheme.textSecondary)
                .lineSpacing(4)
            Button(action: {}) {
                Text("チャレンジ開始")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(AppTheme.primary, in: RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(LinearGradient(colors: [AppTheme.lightBg, .white],
                                     startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(AppTheme.midBlue, lineWidth: 1.5)
        )
        .shadow(color: AppTheme.midBlue.opacity(0.4), radius: 8, y: 2)
    }

    // MARK: Subjects
    private var subjectSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("科目から学ぶ")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(AppTheme.textPrimary)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(vm.subjects) { subject in
                    SubjectCardView(subject: subject) {
                        onStartQuiz?(subject)
                    }
                }
            }
        }
    }
}

struct SubjectCardView: View {
    let subject: Subject
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Image(systemName: subject.systemIcon)
                    .font(.system(size: 20))
                    .foregroundStyle(subject.iconColor)
                    .frame(width: 44, height: 44)
                    .background(subject.bgColor, in: RoundedRectangle(cornerRadius: 12))
                VStack(alignment: .leading, spacing: 2) {
                    Text(subject.name)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(AppTheme.textPrimary)
                    Text("\(subject.questionCount)問")
                        .font(.system(size: 12))
                        .foregroundStyle(AppTheme.textSecondary)
                }
                Spacer()
            }
            .padding(12)
            .background(AppTheme.cardBg, in: RoundedRectangle(cornerRadius: 16))
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(AppTheme.border, lineWidth: 1))
            .shadow(color: .black.opacity(0.04), radius: 4, y: 1)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeView()
}
