//
//  OpenAIFile.swift
//  HomeworkAI
//
//  Created by Aftaab Mulla on 16/10/25.
//

import Foundation
import OpenAI

class OpenAIManager {
    
    let openAI = OpenAI(apiToken: "YOUR API KEYS")
    
    func query(prompt: String) async -> ChatResult? {
        let Content = "You are homework AI.Your job is to help School Students"
        
        guard let systemChatQuery = ChatQuery.ChatCompletionMessageParam(role: .system, content: Content) else {
            return nil
        }
        
        guard let userChatQuery = ChatQuery.ChatCompletionMessageParam(role: .user, content: prompt) else {
            return nil
        }
        
        let chatQuery = ChatQuery(messages: [systemChatQuery, userChatQuery], model: .gpt5)
        
        do {
            let result = try await openAI.chats(query: chatQuery)
            return result
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
