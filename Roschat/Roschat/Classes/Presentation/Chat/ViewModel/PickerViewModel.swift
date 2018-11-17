//
//  PickerViewModel.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class PickerViewModel: FieldViewModel {
    var value: String?
    var variants: [String]
    
    init(dto: PickerFieldDto) {
        self.value = dto.value
        self.variants = dto.variants
        super.init(dto:dto)
    }
}
