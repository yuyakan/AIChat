//
//  ContentView.swift
//  AIChatiOS
//
//  Created by 上別縄祐也 on 2025/06/16.
//

import SwiftUI

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
