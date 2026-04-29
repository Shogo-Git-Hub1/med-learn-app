# med-learn-app

MedQuiz 関連の学習・プロトタイプ用リポジトリです。

## 推奨ワークフロー（Cursor と Xcode）

| Cursor（Claude Code） | Xcode |
| --- | --- |
| ファイル生成・編集 | ビルド・実行 |
| プロジェクト構成 | SwiftUI Preview 確認 |
| Firebase 設定 | シミュレーターでデバッグ |
| コードレビュー・修正 | エラー確認 |

同じプロジェクトフォルダを両方で開けるので、Cursor で書いて Xcode でビルド確認するサイクルが最も効率的です。

## フォルダ構成

```text
med-learn-app/
├─ Core/
│  ├─ Models/
│  │  ├─ AppUser.swift
│  │  ├─ Question.swift
│  │  └─ Subject.swift
│  └─ Services/
│     ├─ AuthService.swift
│     └─ QuizService.swift
├─ Features/
│  ├─ Home/
│  │  ├─ HomeView.swift
│  │  └─ HomeViewModel.swift
│  ├─ Courses/
│  │  └─ CoursesView.swift
│  ├─ Quiz/
│  │  ├─ QuizView.swift
│  │  └─ QuizViewModel.swift
│  ├─ Review/
│  │  └─ ReviewView.swift
│  └─ Profile/
│     └─ ProfileView.swift
├─ Shared/
│  ├─ Components/
│  │  ├─ BadgeView.swift
│  │  ├─ StatCardView.swift
│  │  └─ XPBarView.swift
│  └─ Theme/
│     └─ AppTheme.swift
├─ Assets.xcassets/
├─ med-learn-app.xcodeproj/
├─ med_learn_appApp.swift
├─ ContentView.swift
├─ README.md
├─ ios-frame.jsx
└─ MedQuiz App.html
```

## 各フォルダ・ファイルの特徴

- `Core/`: アプリの土台となる層です。`Models` はデータ構造、`Services` は認証やクイズ処理などのロジックを担当します。
- `Features/`: 画面や機能ごとの実装をまとめる層です。`Home` や `Quiz` など、機能単位で `View` と `ViewModel` を分離しています。
- `Shared/`: 複数機能で再利用する共通UIとテーマ定義を置く層です。`Components` は共通部品、`Theme` は見た目の基準です。
- `Assets.xcassets/`: アプリアイコン、色、画像などのアセットを管理します。
- `med-learn-app.xcodeproj/`: Xcode のプロジェクト設定、ビルド設定、スキーム情報を保持します。
- `med_learn_appApp.swift`: SwiftUI アプリのエントリーポイントです。
- `ContentView.swift`: 初期画面や画面遷移の起点となるビューです。
- `ios-frame.jsx` と `MedQuiz App.html`: Swift 本体とは別に、UIモックや試作用のフロントエンド素材として利用できます。
