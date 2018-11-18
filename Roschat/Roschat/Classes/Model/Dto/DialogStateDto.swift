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

struct ButtonDto: Decodable {
    var id: Int
    var text: String
    var endpoint: String
}

class DialogStateDto {
    var id: Int
    var type: DialogStateType
    var messageDto: JSON
    var dialogStyleType: DialogMessageStyle
    var formDto: FormDto!
    var views: [ViewDto]?
    var buttons: [ButtonDto]!
    var endpoint: String?
    
    init?(json: JSON) {
        self.id = json["id"].intValue
        self.type = DialogStateType(rawValue: json["type"].stringValue) ?? .undefined
        self.dialogStyleType = DialogMessageStyle(rawValue: json["style"].stringValue) ?? .normal
        
        self.messageDto = json["message"]
        
        self.endpoint = json["endpoint"].string
        
        if self.type == .form {
            formDto = FormDto(json: json["form"])
        }
        
        if self.type == .button {
            let decoder = JSONDecoder()
            
            guard
                let data = try? json["buttons"].rawData(),
                let array = try? decoder.decode([ButtonDto].self, from: data)
                else { fatalError() }
            buttons = array;
        }
        
        if let viewsJsonArray = json["view"].array {
            self.views = ViewDtoParser.parseDtos(jsonArray: viewsJsonArray)
        }
    }
    
    func getMessage() -> String {
        return self.messageDto[dialogStyleType.rawValue].string ?? self.messageDto[DialogMessageStyle.normal.rawValue].string ?? "ОШИБКА ВАРИАНТА ДИАЛОГА"
    }
}
