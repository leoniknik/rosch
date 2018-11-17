//
//  AuthCardConfigByOtp.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

final class AuthCardConfigByOtp: RequestConfig<User> {
    
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
