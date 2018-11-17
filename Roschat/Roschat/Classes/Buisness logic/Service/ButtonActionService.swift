//
//  ButtonActionService.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

final class ButtonActionService {
    
    typealias ButtonActionSendCompletion = ((Result<DialogStateDto>) -> Void)?
    
    let requestSender: RequestSenderProtocol
    let tokenService: TokenService
    
    init(requestSender: RequestSenderProtocol, tokenService: TokenService) {
        self.requestSender = requestSender
        self.tokenService = tokenService
    }
    
    func sendButtonAction(endpoint: String, buttonID: Int, completion: ButtonActionSendCompletion) {
        guard let token = tokenService.accessToken else { return }
        let config = SendButtonActionConfig(token, endpoint: endpoint, buttonID: buttonID)
        requestSender.request(config: config) { (result) in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    completion?(result)
                }
            case .error:
                print("error")
            }
        }
    }
}
