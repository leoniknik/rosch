//
//  UserService.swift
//  Roschat
//
//  Created by Кирилл Володин on 16/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class UserService {
    
    typealias AuthUserCompletion = ((Result<User>) -> Void)?
    
    let requestSender: RequestSenderProtocol
    let tokenService: TokenService
    
    init(requestSender: RequestSenderProtocol, tokenService: TokenService) {
        self.requestSender = requestSender
        self.tokenService = tokenService
    }
    
    func authUser(cardNumber: String, completion: AuthUserCompletion) {
        
    }
}
