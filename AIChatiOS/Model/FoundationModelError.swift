//
//  FoundationModelError.swift
//  AIChatiOS
//
//  Created by 上別縄祐也 on 2025/06/16.
//

import Foundation

enum FoundationModelError: LocalizedError {
    case sessionNotAvailable
    case modelNotSupported
    
    var errorDescription: String? {
        switch self {
        case .sessionNotAvailable:
            return "Foundation Modelのセッションが利用できません"
        case .modelNotSupported:
            return "このデバイスではFoundation Modelがサポートされていません"
        }
    }
}
