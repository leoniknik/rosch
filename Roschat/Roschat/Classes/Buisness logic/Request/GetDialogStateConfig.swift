//
//  GetDialogStateConfig.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//


import Foundation
import Alamofire

final class GetDialogStateConfig: RequestConfig<DialogStateDto> {
    
    init(_ token: String) {
        let parameters: Parameters = [:]
        let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
        super.init(url: "/api/user/ds",
                   parameters: parameters,
                   headers: headers,
                   method: .get,
                   encoding: URLEncoding.queryString,
                   parser: DialogStateDtoParser())
    }
}
