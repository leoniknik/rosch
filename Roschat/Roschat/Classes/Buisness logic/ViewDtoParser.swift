//
//  ViewDtoParser.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class ViewDtoParser {
    static func parseDtos(jsonArray: [JSON]) -> [ViewDto] {
        var dtos = [ViewDto]()
        for json in jsonArray {
            let type = ViewTypeDto(rawValue: json["type"].stringValue) ?? .undefined
            switch type {
            case .doc:
                dtos.append(DocViewDto(json: json))
            case .photo:
                dtos.append(PhotoViewDto(json: json))
            case .selector:
                fatalError()
            case .url:
                dtos.append(UrlViewDto(json: json))
            case.undefined:
                fatalError()
            }
        }
        return dtos
    }
}
