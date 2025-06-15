//
//  ChatMessage.swift
//  AIChatiOS
//
//  Created by 上別縄祐也 on 2025/06/16.
//

import Foundation

struct ChatMessage: Identifiable, Codable {
    var id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date
    
    init(content: String, isUser: Bool) {
        self.content = content
        self.isUser = isUser
        self.timestamp = Date()
    }
}
