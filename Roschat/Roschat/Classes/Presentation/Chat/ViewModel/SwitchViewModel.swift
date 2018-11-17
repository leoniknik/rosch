//
//  SwitchViewModel.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class SwitchViewModel: FieldViewModel {
    var value: Bool = false
    
    init(dto: SwitchFieldDto) {
        value = dto.value
        super.init(dto: dto)
    }
}
