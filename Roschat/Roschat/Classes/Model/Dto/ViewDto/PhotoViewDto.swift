//
//  PhotoViewDto.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class  PhotoViewDto: ViewDto {
    var fileId: Int
    
    override init(json: JSON) {
        self.fileId = json["fileId"].intValue
        super.init(json: json)
    }
}
