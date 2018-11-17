//
//  GetDialogHistoryConfig.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

final class GetDialogHistoryConfig: RequestConfig<[HistoryDto]> {
    
    init(_ token: String) {
        let parameters: Parameters = [:]
        let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
        super.init(url: "/api/user/history",
                   parameters: parameters,
                   headers: headers,
                   method: .get,
                   encoding: URLEncoding.queryString,
                   parser: HistoryDtoParser())
    }
}
