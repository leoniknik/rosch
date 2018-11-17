//
//  SliderFieldDto.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class SliderFieldDto: FormFieldDto {
    var min: Double
    var max: Double
    var value: Double?
    override init(json: JSON) {
        self.value = json["value"].double
        self.min = json["min"].doubleValue
        self.max = json["max"].doubleValue
        super.init(json: json)
    }
}
