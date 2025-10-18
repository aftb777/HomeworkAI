//
//  ChatThreadViewModel.swift
//  HomeworkAI
//
//

import Foundation
import SwiftUI

@Observable
class ChatThreadViewModel {
    
    var chatText = ""
    var isLoading = false
    var textEditorHeight : CGFloat = 20
    let openAI = OpenAIManager()
    var chats: [Chat] = []
    var sortedChats: [Chat] {
       return chats.sorted(by: { $0.createdAt < $1.createdAt })
    }
    
    func fetchSolutions() async {
        guard chatText.count > 0 else { return }
        
        let chatMessage = Chat(id: UUID().uuidString, isAI: false, text: chatText)
        chats.append(chatMessage)
        isLoading = true
        
        guard let result = await openAI.query(prompt: chatText) else {
            return
        }
        
        chatText = ""
        
        guard let firstChoice = result.choices.first else {
            return
        }
        
        guard let solution = firstChoice.message.content else {
            return
        }
        
        let aiChat = Chat(id: UUID().uuidString, isAI: true, text: solution)
        chats.append(aiChat)
    }
}
