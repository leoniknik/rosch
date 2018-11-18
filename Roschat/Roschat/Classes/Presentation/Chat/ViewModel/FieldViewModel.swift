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
    case money
    case slider
}

class FieldViewModel {
    let type: FieldType
    
    let name: String
    let label: String
    var editable: Bool
    let hint: String?
    
    init(dto: FormFieldDto) {
        switch dto.type {
        case .text:
            self.type = .input
        case .date:
            self.type = .date
        case .num:
            self.type = .input
        case .label:
            self.type = .info
        case .money:
            self.type = .money
        case .picker:
            self.type = .picker
        case .slider:
            self.type = .slider
        case .switcher:
            self.type = .switchType
        case .undef:
            fatalError()
        }
        
        self.name = dto.name
        self.label = dto.label
        self.editable = dto.editable
        self.hint = dto.hint
    }
    
    init() {
        self.name = ""
        self.label = ""
        self.editable = true
        self.hint = ""
        type = .button
    }
}
