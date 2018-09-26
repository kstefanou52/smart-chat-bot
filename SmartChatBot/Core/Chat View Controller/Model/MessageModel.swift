//
//  MessageModel.swift
//  SmartChatBot
//
//  Created by Kostis on 21/09/2018.
//  Copyright © 2018 Atcom. All rights reserved.
//

import Foundation

class MessageModel {
    var senderName: String?
    var senderAvatar: Data?
    var senderText: String?
    
    init(senderName: String?, senderAvatar: Data?, senderText: String?) {
        self.senderName = senderName
        self.senderAvatar = senderAvatar
        self.senderText = senderText
    }
}
