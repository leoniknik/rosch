//
//  ChatService.swift
//  Roschat
//
//  Created by Кирилл Володин on 16/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class ChatService {
    
    let requestSender: RequestSenderProtocol
    let userService: UserService
    
    init(requestSender: RequestSenderProtocol, userService: UserService) {
        self.requestSender = requestSender
        self.userService = userService
    }
        
}
