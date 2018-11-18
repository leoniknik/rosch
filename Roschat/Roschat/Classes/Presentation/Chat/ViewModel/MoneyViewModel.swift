//
//  MoneyViewModel.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

enum Currency: String {
    case RUR
    case EUR
    case USD
    
    func getSign() -> String {
        switch self {
        case .EUR:
            return "E"
        case .USD:
            return "S"
        case .RUR:
            return "R"
        }
    }
}

class MoneyViewModel: FieldViewModel {
    var value: Double = 0
    var currency: Currency
    init(dto: MoneyFieldDto) {
        if let val = dto.value {
            self.value = val
        }
        guard let cur = Currency(rawValue: dto.currency) else { fatalError() }
        self.currency = cur
        super.init(dto: dto)
    }
}
