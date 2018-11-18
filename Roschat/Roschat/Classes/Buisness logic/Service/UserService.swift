//
//  UserService.swift
//  Roschat
//
//  Created by Кирилл Володин on 16/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class UserService {
    
    typealias AuthUserCompletion = ((Result<Otp>) -> Void)?
    typealias UserCompletion = ((Result<User>) -> Void)?
    
    let requestSender: RequestSenderProtocol
    let tokenService: TokenService
    
    init(requestSender: RequestSenderProtocol, tokenService: TokenService) {
        self.requestSender = requestSender
        self.tokenService = tokenService
    }
    
    func authUser(cardNumber: String, completion: UserCompletion) {
        let config = AuthCardConfig(cardNumber: cardNumber)
        requestSender.request(config: config) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let result):
                self.authByOtp(otp: result.otp, cardNumber: cardNumber, completion: completion)
            case .error:
                DispatchQueue.main.async {
                    completion?(Result.error("Ошибка"))
                }
            }
        }
    }
    
    func authByOtp(otp: Int, cardNumber: String, completion: UserCompletion) {
        let config = AuthCardConfigByOtp(otp: otp, cardNumber: cardNumber)
        requestSender.request(config: config) { (result) in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    completion?(result)
                }
            case .error:
                DispatchQueue.main.async {
                    completion?(Result.error("Ошибка"))
                }
            }
        }
    }
}
