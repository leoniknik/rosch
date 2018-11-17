//
//  AuthCardConfig.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

final class AuthCardConfig: RequestConfig<Otp> {
    
    init(cardNumber: String) {
        let parameters: Parameters = [
            "cardNumber": cardNumber
        ]
        
        super.init(url: "/api/auth/user/login",
                   parameters: parameters,
                   method: .post,
                   encoding: JSONEncoding.default,
                   parser: Otp.self)
    }
}
