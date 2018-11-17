//
//  TokenService.swift
//  Roschat
//
//  Created by Кирилл Володин on 16/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class TokenService {
    var accessToken: String?
    
    func clear() {
        accessToken = nil
    }
}
