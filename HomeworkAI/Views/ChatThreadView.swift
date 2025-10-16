//
//  ChatThreadView.swift
//  HomeworkAI
//
//

import SwiftUI

struct ChatThreadView: View {
    
    @State var viewModel = ChatThreadViewModel()
    
    private func SentMessage(chat: Chat) -> some View {
        HStack{
            Spacer()
            Text(chat.text)
                .font(.system(size: 15))
                .foregroundStyle(Color.white)
                .padding()
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 17))
                .padding(.trailing)
                .padding(.leading, 55)
        }
    }
    
    private func RecievedMessage(chat: Chat) -> some View {
        HStack{
            Text(chat.text)
                .font(.system(size: 15))
                .foregroundStyle(Color.white)
                .padding()
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 17))
                .padding(.trailing, 55)
                .padding(.leading)
            Spacer()
        }
    }
    
    private var ChatBottomBar: some View {
        HStack {
            ZStack {
                Text(viewModel.chatText)
                                    .foregroundColor(Color("placeholder"))
                                    .padding(.leading)
                                    .background(GeometryReader {
                                        Color.clear.preference(key: ExpandableTextViewHeightKey.self,
                                                                value: $0.frame(in: .local).size.height)
                                    })
                                    .opacity(viewModel.chatText.isEmpty ? 1 : 0)
                TextEditor(text: $viewModel.chatText)
                    .frame(height: max(40, viewModel.textEditorHeight))
                    .background(Color(uiColor: UIColor.lightGray.withAlphaComponent(0.3)))
                    .scrollContentBackground(.hidden)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.leading)
            }
            Button(action: {
                
            }, label: {
                Text("Send")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.white)
            })
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.blue)
            .cornerRadius(4)
        }
        .onPreferenceChange(ExpandableTextViewHeightKey.self) { viewModel.textEditorHeight = ($0 + 18) }
        .padding(.horizontal)
    }
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.sortedChats) { chat in
                            if !chat.isAI {
                                SentMessage(chat: chat)
                            }
                            else {
                                RecievedMessage(chat: chat)
                            }
                        }
                    }
                }
                Spacer()
                ChatBottomBar
                      .padding(.bottom)
            }
            .onAppear(perform: {
                viewModel.chats.append(Chat(id: UUID().uuidString, isAI: true, text: "Hello, I am Homework AI. My purpose is to help with all your homework related issues. What can I help you with today?"))
            })
            if viewModel.isLoading {
                LoadingComponentView()
            }
        }
    }
}

struct ExpandableTextViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

#Preview {
    ChatThreadView()
}
