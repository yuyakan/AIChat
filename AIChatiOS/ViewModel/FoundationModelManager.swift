//
//  FoundationModels.swift
//  AIChatiOS
//
//  Created by 上別縄祐也 on 2025/06/16.
//

import SwiftUI
import FoundationModels

@Observable
class FoundationModelManager {
    private var session: LanguageModelSession?
    
    init() {
        setupSession()
    }
    
    private func setupSession() {
        // システム指示を設定
        let instructions = """
        あなたは親切で知識豊富なAIアシスタントです。
        ユーザーの質問に対して、明確で有用な回答を提供してください。
        回答は簡潔で理解しやすいものにしてください。
        """
        
        // LanguageModelSession を作成
        session = LanguageModelSession(instructions: instructions)
    }
    
    // シンプルなテキスト生成
    func generateResponse(for prompt: String) async throws -> String {
        guard let session = session else {
            throw FoundationModelError.sessionNotAvailable
        }
        
        let response = try await session.respond(to: prompt)
        return response.content
    }
}
