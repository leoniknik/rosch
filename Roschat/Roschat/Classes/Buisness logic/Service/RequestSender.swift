//
//  RequestSender.swift
//  Roschat
//
//  Created by Кирилл Володин on 16/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

enum Result<T> {
    case success(T)
    case error(String)
}

protocol RequestSenderProtocol: class {
    typealias CompletionHandler<Model> = ((Result<Model>) -> Void)?
    func request<Model>(config: RequestConfig<Model>, completionHandler: CompletionHandler<Model>)
}

final class RequestSender: RequestSenderProtocol {
    
    var sessionManager: SessionManager
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func request<Model>(config: RequestConfig<Model>, completionHandler: CompletionHandler<Model>) {
        let utilityQueue = DispatchQueue.global(qos: .utility)
        sessionManager.request(config.url,
                               method: config.method,
                               parameters: config.parameters,
                               encoding: config.encoding,
                               headers: config.headers)
            .validate()
            .responseJSON(queue: utilityQueue) { response in
                switch response.result {
                case .success:
                    guard let result = config.parser.parse(response) else {
                        completionHandler?(Result.error("Ошибка при получении данных"))
                        return
                    }
                    completionHandler?(Result.success(result))
                case .failure(let error):
                    debugPrint(error)
                    completionHandler?(Result.error("Нет связи с сервером"))
                }
        }
    }
    

    
//    func request<Model>(config: RequestConfig<Model>, completionHandler: CompletionHandler<Model>) {
//        let utilityQueue = DispatchQueue.global(qos: .utility)
//
//        let manager = Alamofire.SessionManager.default
//
//        manager.request(config.url,
//                        method: config.method,
//                        parameters: config.parameters,
//                        encoding: config.encoding,
//                        headers: config.headers)
//            .validate()
//            .responseJSON(queue: utilityQueue) { response in
//                switch response.result {
//                case .success:
//                    guard let data = response.data else {
//                        completionHandler?(Result.error("Что-то не так"))
//                        return
//                    }
//                    do {
//                        let result = try JSONDecoder().decode(config.parser, from: data)
//                        completionHandler?(Result.success(result))
//                    } catch let error {
//                        debugPrint(error)
//                        completionHandler?(Result.error("Ошибка сервера"))
//                    }
//                case .failure(let error):
//                    print(error)
//                    completionHandler?(Result.error("Не удается подключиться к серверу"))
//                    return
//                }
//        }
//    }
}
