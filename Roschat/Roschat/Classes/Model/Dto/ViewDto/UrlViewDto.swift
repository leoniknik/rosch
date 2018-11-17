//
//  UrlViewDto.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class UrlViewDto: ViewDto {
    var fileId: Int
    var image: String
    var url: String

    override init(json: JSON) {
        self.fileId = json["fileId"].intValue
        self.image = json["image"].stringValue
        self.url = json["url"].stringValue
        super.init(json: json)
    }
}

