//
//  ChatViewModel.swift
//  AIChatiOS
//
//  Created by 上別縄祐也 on 2025/06/16.
//

import SwiftUI

@Observable
class ChatViewModel {
    var messages: [ChatMessage] = []
    var inputText: String = ""
    var isLoading: Bool = false
    
    private let foundationModel = FoundationModelManager()
    
    func sendMessage() {
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let userMessage = ChatMessage(content: inputText, isUser: true)
        messages.append(userMessage)
        
        let prompt = inputText
        inputText = ""
        
        generateResponse(for: prompt)
    }
    
    private func generateResponse(for prompt: String) {
        isLoading = true
        
        Task {
            do {
                let response = try await foundationModel.generateResponse(for: prompt)
                
                await MainActor.run {
                    let aiMessage = ChatMessage(content: response, isUser: false)
                    messages.append(aiMessage)
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    let errorMessage = ChatMessage(
                        content: "エラーが発生しました: \(error.localizedDescription)",
                        isUser: false
                    )
                    messages.append(errorMessage)
                    isLoading = false
                }
            }
        }
    }
    
    func clearChat() {
        messages.removeAll()
    }
}
