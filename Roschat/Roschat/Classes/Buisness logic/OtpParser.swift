//
//  OtpParser.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import Alamofire

class OtpParser: Parser<Otp> {
    override func parse(_ response: DataResponse<Any>) -> Otp? {
        guard let data = response.data else { return nil }
        do {
            let model = try JSONDecoder().decode(Otp.self, from: data)
            return model
        } catch {
            return nil
        }
    }
}
