//
//  DialogStateDtoParser.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DialogStateDtoParser: Parser<DialogStateDto> {
    override func parse(_ response: DataResponse<Any>) -> DialogStateDto? {
        guard
            let data = response.data,
            let json = try? JSON(data: data)
            else { return nil }
        return DialogStateDto(json: json)
    }
}
