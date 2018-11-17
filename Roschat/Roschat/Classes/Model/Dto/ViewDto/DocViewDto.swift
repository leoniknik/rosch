//
//  DocViewDto.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class  DocViewDto: ViewDto {
    var imgUrl: String
    var fileId: Int
    
    override init(json: JSON) {
        self.imgUrl = json["imgUrl"].stringValue
        self.fileId = json["fileId"].intValue
        super.init(json: json)
    }
}
