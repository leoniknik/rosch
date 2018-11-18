//
//  UserMessageDto.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserMessageDto {
    var type: DialogStateType
    var strValue: String!
    var jsonValue: JSON!
    
    init(json: JSON) {
        self.type = DialogStateType(rawValue: json["type"].stringValue) ?? .undefined
        switch type {
        case .form:
            jsonValue = json["value"]
        case .button, .doc, .photo, .text:
            strValue = json["value"].stringValue
        default:
            fatalError()
        }
    }
    init(type: DialogStateType,
         strValue: String? = nil,
        jsonValue: JSON? = nil) {
        self.type = type
        self.strValue = strValue
        self.jsonValue = jsonValue
    }
}
