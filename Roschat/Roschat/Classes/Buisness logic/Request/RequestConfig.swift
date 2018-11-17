//
//  RequestConfig.swift
//  Roschat
//
//  Created by Кирилл Володин on 16/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

class RequestConfig<Parser> where Parser: Decodable {
    var baseURL = ""
    var url: String
    var endPoint: String
    var parameters: Parameters
    var headers: HTTPHeaders
    var method: HTTPMethod
    var encoding: ParameterEncoding
    var parser: Parser.Type
    
    init(url: String = "",
         parameters: Parameters = [:],
         headers: HTTPHeaders = [:],
         method: HTTPMethod = .get,
         encoding: ParameterEncoding = URLEncoding(destination: .methodDependent),
         parser: Parser.Type) {
        
        self.url = "\(baseURL)\(url)"
        self.endPoint = url
        self.parameters = parameters
        self.headers = headers
        self.method = method
        self.encoding = encoding
        self.parser = parser
    }
}
