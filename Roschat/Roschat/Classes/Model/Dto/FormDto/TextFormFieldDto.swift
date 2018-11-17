//
//  TextFormFieldDto.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class TextFormFieldDto: FormFieldDto {
    var regexp: String
    var placeholder: String?
    var value: String?
    
    override init(json: JSON) {
        self.regexp = json["regexp"].stringValue
        self.placeholder = json["placeholder"].string
        self.value = json["value"].string
        super.init(json: json)
    }
}
