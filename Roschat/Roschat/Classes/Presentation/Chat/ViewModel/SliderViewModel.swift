//
//  SliderViewModel.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 18/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class SliderViewModel: FieldViewModel {
    var value: Double
    var min: Double
    var max: Double
    init(dto: SliderFieldDto) {
        
        self.min = dto.min
        self.max = dto.max
        
        if let val = dto.value {
            self.value = val
        } else {
            value = (max - min) / 2 + min
        }
        
        super.init(dto: dto)
    }
}
