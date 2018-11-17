//
//  TokenService.swift
//  Roschat
//
//  Created by Кирилл Володин on 16/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class TokenService {
    static var accessToken: String?
    
    static func clear() {
        TokenService.accessToken = nil
    }
}
