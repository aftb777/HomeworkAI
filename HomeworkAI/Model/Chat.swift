//
//  Chat.swift
//  HomeworkAI
//
//

import Foundation

struct Chat: Identifiable {
    let id: String
    let isAI: Bool
    let text: String
    let createdAt: Date
    
    init(id: String, isAI: Bool, text: String) {
        self.id = id
        self.isAI = isAI
        self.text = text
        self.createdAt = Date()
    }
    
}
