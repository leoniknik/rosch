//
//  MoneyFieldDto.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class MoneyFieldDto: NumericFieldDto {
    var currency: String
    override init(json: JSON) {
        self.currency = json["currency"].stringValue
        super.init(json: json)
    }
}
