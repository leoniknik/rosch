//
//  DialogStateDto.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

enum DialogStateType: String {
    case button = "BUTTON"
    case form = "FORM"
    case text = "TEX"
    case doc = "DOC"
    case photo = "PHOTO"
    case undefined
}

enum DialogMessageStyle: String {
    case normal
}

struct DialogMessageDto {
    var body: JSON
    
    func getMessage(_ style: DialogMessageStyle) -> String {
        return body[style.rawValue].string ?? body[DialogMessageStyle.normal.rawValue].string ?? "ОШИБКА ВАРИАНТА ДИАЛОГА"
    }
}

class DialogStateDto {
    var id: Int
    var type: DialogStateType
    
    var dialogStyleType: DialogMessageStyle
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.type = DialogStateType(rawValue: json["type"].stringValue) ?? .undefined
        self.dialogStyleType = DialogMessageStyle(rawValue: json["style"].stringValue) ?? .normal
    }
}
