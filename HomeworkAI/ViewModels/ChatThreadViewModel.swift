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
    var chats: [Chat] = []
    var sortedChats: [Chat] {
       return chats.sorted(by: { $0.createdAt < $1.createdAt })
    }
    
}
