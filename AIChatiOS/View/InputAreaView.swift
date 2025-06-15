//
//  InputAreaView.swift
//  AIChatiOS
//
//  Created by 上別縄祐也 on 2025/06/16.
//

import SwiftUI

struct InputAreaView: View {
    @Bindable var viewModel: ChatViewModel
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        HStack {
            TextField("メッセージを入力...", text: $viewModel.inputText, axis: .vertical)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($isTextFieldFocused)
                .onSubmit {
                    viewModel.sendMessage()
                }
                .disabled(viewModel.isLoading)
            
            Button(action: {
                viewModel.sendMessage()
            }) {
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(0.8)
                } else {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                }
            }
            .disabled(viewModel.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                     viewModel.isLoading)
        }
        .padding()
    }
}

