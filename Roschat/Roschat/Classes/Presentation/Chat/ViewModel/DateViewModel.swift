//
//  DateViewModel.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

class DateViewModel: FieldViewModel {
    var value: Date?
    
    init(dto: DatePickerFieldDto) {
        self.value = dto.value
        super.init(dto: dto)
    }
}
