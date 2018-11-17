//
//  HistoryDtoParser.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HistoryDtoParser: Parser<[HistoryDto]> {
    
    override func parse(_ response: DataResponse<Any>) -> [HistoryDto]? {
        guard
            let data = response.data,
            let jsonArray = try? JSON(data: data).arrayValue
            else { return nil }
        var dtos = [HistoryDto]()
        for json in jsonArray {
            dtos.append(HistoryDto(json: json))
        }
        return dtos
    }
}
