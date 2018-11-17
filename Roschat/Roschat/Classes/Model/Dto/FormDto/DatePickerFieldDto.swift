//
//  DatePickerFieldDto.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class DatePickerFieldDto: FormFieldDto {
    var value: Date?
    
    override init(json: JSON) {
        if let fromEpoch = json["value"].double {
            self.value = Date(timeIntervalSinceNow: fromEpoch)
        }
        super.init(json: json)
    }
}
