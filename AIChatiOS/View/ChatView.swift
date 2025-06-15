//
//  ContentView.swift
//  AIChatiOS
//
//  Created by 上別縄祐也 on 2025/06/16.
//

import SwiftUI
import FoundationModels

struct MessageView: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                VStack(alignment: .trailing) {
                    Text(message.content)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    Text(message.timestamp, style: .time)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            } else {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "brain.head.profile")
                            .foregroundColor(.blue)
                        Text("AI Assistant")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Text(message.content)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .textSelection(.enabled) // テキスト選択可能
                    
                    Text(message.timestamp, style: .time)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

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

struct ChatView: View {
    @State private var viewModel = ChatViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // メッセージリスト
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.messages) { message in
                                MessageView(message: message)
                                    .id(message.id)
                                    .transition(.opacity.combined(with: .slide))
                            }
                            
                            if viewModel.isLoading {
                                HStack {
                                    Image(systemName: "brain.head.profile")
                                        .foregroundColor(.blue)
                                    Text("考え中...")
                                        .foregroundColor(.secondary)
                                    ProgressView()
                                        .scaleEffect(0.8)
                                    Spacer()
                                }
                                .padding()
                                .transition(.opacity)
                            }
                        }
                    }
                    .onChange(of: viewModel.messages.count) { _, _ in
                        if let lastMessage = viewModel.messages.last {
                            withAnimation(.easeOut(duration: 0.3)) {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                Divider()
                
                // 入力エリア
                InputAreaView(viewModel: viewModel)
            }
            .navigationTitle("AI Chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("クリア") {
                        withAnimation {
                            viewModel.clearChat()
                        }
                    }
                    .disabled(viewModel.messages.isEmpty)
                }
            }
            .animation(.easeInOut, value: viewModel.messages.count)
        }
    }
}
