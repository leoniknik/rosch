//
//  FieldViewModel.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

enum FieldType {
    case switchType
    case input
    case info
    case date
    case picker
    case button
}

class FieldViewModel {
    let type: FieldType
    
    init(type: FieldType) {
        self.type = type
    }
}
