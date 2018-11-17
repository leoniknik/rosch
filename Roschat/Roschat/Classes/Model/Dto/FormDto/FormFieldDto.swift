//
//  FormFieldDto.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class FormFieldDto {
    var name: String
    var label: String
    var type: FormFieldType
    var editable: Bool = true
    var hint: String?
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.label = json["label"].stringValue
        self.type = FormFieldType(rawValue: json["type"].stringValue) ?? .undef
        self.editable = json["enabled"].boolValue
        self.hint = json["hint"].string
    }
}
