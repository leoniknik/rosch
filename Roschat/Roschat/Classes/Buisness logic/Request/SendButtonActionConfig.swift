//
//  SendButtonActionConfig.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

final class SendButtonActionConfig: RequestConfig<DialogStateDto> {
    
    init(_ token: String, endpoint: String, buttonID: Int) {
        let parameters: Parameters = ["id": buttonID]
        let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
        super.init(url: endpoint,
                   parameters: parameters,
                   headers: headers,
                   method: .post,
                   encoding: JSONEncoding.default,
                   parser: DialogStateDtoParser())
    }
}
