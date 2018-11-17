//
//  TokenService.swift
//  Roschat
//
//  Created by Кирилл Володин on 16/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class TokenService {
    var accessToken: String? = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhY2Nlc3MiLCJqdGkiOiIxIiwiYXVkIjoiVVNFUiIsImV4cCI6MTU0MjQ4MDQwNH0.fD-21FrMgAftf9HNEik02NvOn05SXM3__a0iuwsyO-eUdxxOSVtXt0xzT8FGZcNGfmzn1l9I7__pKbuTGlOzUg"
    
    func clear() {
        accessToken = nil
    }
}
