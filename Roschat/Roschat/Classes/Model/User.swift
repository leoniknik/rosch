//
//  User.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

struct User: Decodable {
    let accessToken: String
    let id: Int
}
