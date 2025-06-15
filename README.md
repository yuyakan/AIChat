# FoundationModels チャットアプリ

Apple IntelligenceのFoundationModelsフレームワークを使用したシンプルなチャットアプリです。オンデバイスで動作するため、プライバシーが保護され、オフラインでも利用できます。

## 📱 デモ
<video src="https://github.com/user-attachments/assets/bc52afdd-e593-4f61-8c0f-7666b6dc269b" controls="true" width="200"></video>



## ✨ 機能

- **🤖 AI チャット**: Apple Intelligenceとの自然な会話
- **🔒 完全プライベート**: オンデバイス処理（データが外部送信されない）
- **📱 オフライン対応**: インターネット接続不要
- **⚡ 高速**: デバイス内蔵LLMによる素早い応答
- **🧹 履歴クリア**: チャット履歴の一括削除
- **📋 テキスト選択**: AIの回答をコピー可能

## 🛠 技術スタック

- **Swift 6.2+**
- **SwiftUI**
- **FoundationModels Framework**
- **Apple Intelligence**

## 📋 必要要件

### システム要件
- **iOS 18.0** 以降
- **macOS 15.0** 以降 (Mac版の場合)
- **iPadOS 18.0** 以降 (iPad版の場合)
- **visionOS 2.0** 以降 (Vision Pro版の場合)

### デバイス要件
Apple Intelligence対応デバイス:
- **iPhone**: iPhone 15 Pro, iPhone 15 Pro Max, iPhone 16シリーズ
- **iPad**: M1チップ以降搭載のiPad
- **Mac**: Apple Silicon (M1, M2, M3, M4) 搭載Mac

### 設定要件
1. **Apple Intelligenceの有効化**
   - 設定 > Apple Intelligence & Siri
   - Apple Intelligenceをオンにする
2. **地域設定**: 対応地域に設定されていること
3. **言語設定**: 対応言語に設定されていること

## 🚀 インストール・実行方法

### 1. リポジトリのクローン
```bash
git clone https://github.com/your-username/foundation-models-chat.git
cd foundation-models-chat
```

### 2. Xcodeで開く
```bash
open FoundationModelsChatApp.xcodeproj
```

### 3. 実行
1. Apple Intelligence対応デバイスを接続
2. ターゲットデバイスを選択
3. ⌘+R で実行

## 📁 プロジェクト構造

```
FoundationModelsChatApp/
├── App/
│   └── FoundationModelsChatApp.swift    # アプリエントリーポイント
├── Models/
│   ├── ChatMessage.swift                # メッセージデータモデル
│   └── FoundationModelError.swift       # エラー定義
├── ViewModels/
│   ├── FoundationModelManager.swift     # LLM管理クラス
│   └── ChatViewModel.swift              # チャット画面ビューモデル
├── Views/
│   ├── ChatView.swift                   # メインチャット画面
│   ├── MessageView.swift                # メッセージ表示ビュー
│   └── InputAreaView.swift              # 入力エリアビュー
└── README.md
```

## 🏗 アーキテクチャ

### MVVM パターン
- **Model**: `ChatMessage`, `FoundationModelError`
- **ViewModel**: `ChatViewModel`, `FoundationModelManager`
- **View**: `ChatView`, `MessageView`, `InputAreaView`

### データフロー
```
ユーザー入力 → ChatViewModel → FoundationModelManager → LanguageModelSession
                     ↓
AI応答 ← ChatViewModel ← FoundationModelManager ← LanguageModelSession
       ↓
   ChatView (UI更新)
```

## 🔧 主要コンポーネント

### FoundationModelManager
```swift
class FoundationModelManager {
    private var session: LanguageModelSession?
    
    func generateResponse(for prompt: String) async throws -> String
    var isModelAvailable: Bool
}
```
- LanguageModelSessionの管理
- AI応答の生成
- モデル利用可能性の確認

### ChatViewModel
```swift
@Observable
class ChatViewModel {
    var messages: [ChatMessage]
    var inputText: String
    var isLoading: Bool
    
    func sendMessage()
    func clearChat()
}
```
- チャット状態の管理
- メッセージ送信処理
- UI状態の制御

## 🎛 カスタマイズ

### システム指示の変更
`FoundationModelManager.swift`の`setupSession()`で指示を変更:

```swift
let instructions = """
あなたは[カスタム指示をここに記述]
"""
```

### UI テーマの変更
`MessageView.swift`でカラーテーマを変更:

```swift
.background(Color.blue)        // ユーザーメッセージ
.background(Color(.systemGray6)) // AIメッセージ
```

## 🐛 トラブルシューティング

### よくある問題

#### 1. "LanguageModelSessionが利用できません"
**原因**: Apple Intelligenceが無効またはデバイス非対応
**解決法**: 
- Apple Intelligence対応デバイスを使用
- 設定でApple Intelligenceを有効化
- iOS 18以降にアップデート

#### 2. アプリがクラッシュする
**原因**: FoundationModelsフレームワークの初期化エラー
**解決法**:
- デバイスを再起動
- Xcodeでクリーンビルド (⌘+Shift+K)
- 最新のXcodeを使用

#### 3. 応答が遅い
**原因**: デバイスのリソース不足
**解決法**:
- 他のアプリを終了
- デバイスを充電
- 低電力モードを無効化

### ログの確認
Xcodeのコンソールでエラー詳細を確認:
```
Console → Filter → "FoundationModels"
```

## 📚 参考資料

- [Apple Developer Documentation - FoundationModels](https://developer.apple.com/documentation/foundationmodels)
- [WWDC 2025 - Meet the Foundation Models framework](https://developer.apple.com/videos/play/wwdc2025/286/)
- [Apple Intelligence ユーザーガイド](https://support.apple.com/guide/iphone/apple-intelligence-iph7b7a5e9b1/ios)

## 🤝 コントリビューション

1. このリポジトリをフォーク
2. 機能ブランチを作成 (`git checkout -b feature/amazing-feature`)
3. 変更をコミット (`git commit -m 'Add some amazing feature'`)
4. ブランチにプッシュ (`git push origin feature/amazing-feature`)
5. プルリクエストを作成

## 📄 ライセンス

このプロジェクトはMITライセンスの下で公開されています。詳細は[LICENSE](LICENSE)ファイルを参照してください。

## 👨‍💻 作者

あなたの名前 - [@your_twitter](https://twitter.com/your_twitter) - your.email@example.com

プロジェクトリンク: [https://github.com/your-username/foundation-models-chat](https://github.com/your-username/foundation-models-chat)

## 🙏 謝辞

- Apple - FoundationModelsフレームワークの提供
- Apple Intelligence チーム - 素晴らしいオンデバイスLLM技術
- Swift コミュニティ - 継続的なサポートと知見の共有

---

**注意**: このアプリはApple Intelligenceの機能を使用するため、対応デバイスでのみ動作します。Apple Intelligenceが利用できない場合、アプリは適切なエラーメッセージを表示します。
