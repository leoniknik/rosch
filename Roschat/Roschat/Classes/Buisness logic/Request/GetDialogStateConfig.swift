//
//  GetDialogStateConfig.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//


import Foundation
import Alamofire

final class GetDialogStateConfig: RequestConfig<DialogStateDto> {
    
    init(otp: Int, cardNumber: String) {
        let parameters: Parameters = [
            "cardNumber": cardNumber,
            "otp": otp
        ]
        
        super.init(url: "/api/auth/user/login",
                   parameters: parameters,
                   method: .post,
                   encoding: JSONEncoding.default,
                   parser: User.self)
    }
}
