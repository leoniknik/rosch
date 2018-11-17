//
//  ViewDto.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

import Foundation
import SwiftyJSON

enum ViewTypeDto: String {
    case selector = "SELECTOR"
    case url = "URL"
    case photo = "PHOTO"
    case doc = "DOC"
    case undefined
}



class ViewDto {
    var type: ViewTypeDto
    var text: String
    init(json: JSON) {
        self.type = ViewTypeDto(rawValue: json["type"].stringValue) ?? .undefined
        self.text = json["text"].stringValue
    }
}

