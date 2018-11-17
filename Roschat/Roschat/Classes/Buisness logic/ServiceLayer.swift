//
//  ServiceLayer.swift
//  Roschat
//
//  Created by Кирилл Володин on 16/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class ServiceLayer {
    
    static let shared = ServiceLayer()
    
    private let requestSender: RequestSenderProtocol
    
    let chatService: ChatService
    let tokenService: TokenService
    let userService: UserService
    let dialogStateService: DialogStateService
    let buttonActionService: ButtonActionService
    
    private init() {
        requestSender = RequestSender()
        tokenService = TokenService()
        userService = UserService(requestSender: requestSender, tokenService: tokenService)
        chatService = ChatService(requestSender: requestSender, userService: userService)
        dialogStateService = DialogStateService(requestSender: requestSender, tokenService: tokenService)
        buttonActionService = ButtonActionService(requestSender: requestSender, tokenService: tokenService)
    }
    
}
