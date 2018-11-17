//
//  PickerFieldDto.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class PickerFieldDto: FormFieldDto {
    var value: String?
    var variants: [String]
    override init(json: JSON) {
        self.value = json["value"].string
        self.variants = json["variants"].arrayObject as? [String] ?? [String]()
        super.init(json: json)
    }
}
