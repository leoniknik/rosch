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
    typealias GetDialogStateHistoryCompletion = ((Result<[HistoryDto]>) -> Void)?
    
    let requestSender: RequestSenderProtocol
    let tokenService: TokenService
    
    init(requestSender: RequestSenderProtocol, tokenService: TokenService) {
        self.requestSender = requestSender
        self.tokenService = tokenService
    }
    
    func getDialogState(completion: GetDialogStateCompletion) {
        guard let token = tokenService.accessToken else { return }
        let config = GetDialogStateConfig(token)
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
    
    func getDialogStateHistory(completion: GetDialogStateHistoryCompletion) {
        guard let token = tokenService.accessToken else { return }
        let config = GetDialogHistoryConfig(token)
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
