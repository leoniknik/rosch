//
//  NumericFieldDto.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class NumericFieldDto: FormFieldDto {
    var regexp: String
    var placeholder: String
    var min: Double?
    var max: Double?
    var value: Double?
    
    override init(json: JSON) {
        self.regexp = json["regexp"].stringValue
        self.placeholder = json["placeholder"].stringValue
        self.min = json["min"].double
        self.max = json["max"].double
        self.value = json["value"].double
        super.init(json: json)
    }
}
