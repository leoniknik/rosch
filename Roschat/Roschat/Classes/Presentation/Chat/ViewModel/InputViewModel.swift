//
//  InputViewModel.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

class InputViewModel: FieldViewModel {
    
    var regexp: String
    var placeholder: String?
    var value: String?
    
    init(dto: TextFormFieldDto) {
        self.value = dto.value
        self.regexp = dto.regexp
        self.placeholder = dto.placeholder
        super.init(dto: dto)
    }
}
