//
//  FormDto.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

enum FormFieldType: String {
    case text = "TEXT"
    case date = "DATE_PICKER"
    case num = "NUMERIC"
    case label = "LABEL"
    case money = "MONEY"
    case picker = "PICKER"
    case slider = "SLIDER"
    case switcher = "SWITCH"
    case undef
}



struct FormDto{
    var fields: [FormFieldDto]
    
    init?(data: Data) {
        guard let json = try? JSON(data: data) else { return nil }
        self.fields = [FormFieldDto]()
        
        let jsons = json["fields"].arrayValue
        for json in jsons {
            let type = FormFieldType(rawValue: json["type"].stringValue) ?? .undef
            
            switch type {
            case .text:
                fields.append(TextFormFieldDto(json: json))
            case .date:
                fields.append(DatePickerFieldDto(json: json))
            case .num:
                fields.append(NumericFieldDto(json: json))
            case .label:
                fields.append(LabelFieldDto(json: json))
            case .money:
                fields.append(MoneyFieldDto(json: json))
            case .picker:
                fields.append(PickerFieldDto(json: json))
            case .slider:
                fields.append(SliderFieldDto(json: json))
            case .switcher:
                fields.append(SwitchFieldDto(json: json))
            case .undef:
                fatalError()
            }
        }
    }
}
