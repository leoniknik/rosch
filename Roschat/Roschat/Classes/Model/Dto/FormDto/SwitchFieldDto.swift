//
//  SwitchFieldDto.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class SwitchFieldDto: FormFieldDto {
    var value: Bool = false
    override init(json: JSON) {
        self.value = json["value"].boolValue
        super.init(json: json)
    }
}
