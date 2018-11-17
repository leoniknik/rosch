//
//  RequestConfig.swift
//  Roschat
//
//  Created by Кирилл Володин on 16/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

class RequestConfig<Model> {
    
    var baseURL = "http://192.168.0.2:8000"
    var url: String
    var parameters: Parameters
    var headers: HTTPHeaders
    var method: HTTPMethod
    var encoding: ParameterEncoding
    var parser: Parser<Model>
    
    init(url: String = "",
         parameters: Parameters = [:],
         headers: HTTPHeaders = [:],
         method: HTTPMethod = .get,
         encoding: ParameterEncoding = URLEncoding(destination: .methodDependent),
         parser: Parser<Model>) {
        
        self.url = "\(baseURL)\(url)"
        self.parameters = parameters
        self.headers = headers
        self.method = method
        self.encoding = encoding
        self.parser = parser
        
    }
}
