//
//  DialogStateService.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation



final class DialogStateService {
    
    typealias GetDialogStateCompletion = ((Result<DialogStateDto>) -> Void)?
    
    
    let requestSender: RequestSenderProtocol
    let tokenService: TokenService
    
    init(requestSender: RequestSenderProtocol, tokenService: TokenService) {
        self.requestSender = requestSender
        self.tokenService = tokenService
    }
    
    func getDialogState(completion: GetDialogStateCompletion) {
        let config = AuthCardConfig(cardNumber: cardNumber)
        requestSender.request(config: config) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let result):
                self.authByOtp(otp: result.otp, cardNumber: cardNumber, completion: completion)
            case .error:
                print("error")
            }
        }
    }
    
    func authByOtp(otp: Int, cardNumber: String, completion: UserCompletion) {
        let config = AuthCardConfigByOtp(otp: otp, cardNumber: cardNumber)
        requestSender.request(config: config) { (result) in
            switch result {
            case .success(let user):
                print(user)
                DispatchQueue.main.async {
                    completion?(result)
                }
            case .error:
                print("error")
            }
        }
    }
}
