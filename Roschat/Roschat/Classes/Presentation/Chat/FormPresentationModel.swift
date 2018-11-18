//
//  FormPresentationModel.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class FormPresentationModel {
    var viewModels = [FieldViewModel]()
    var endpoint: String = ""
    
    init(dto: FormDto) {
        for fieldDto in dto.fields {
            switch fieldDto.type {
            case .text:
                guard let dto = fieldDto as? TextFormFieldDto else { fatalError() }
                viewModels.append(InputViewModel(dto: dto))
            case .date:
                guard let dto = fieldDto as? DatePickerFieldDto else { fatalError() }
                viewModels.append(DateViewModel(dto: dto))
            case .num:
                fatalError()
            case .label:
                guard let dto = fieldDto as? LabelFieldDto else { fatalError() }
                viewModels.append(InfoViewModel(dto: dto))
            case .money:
                guard let dto = fieldDto as? MoneyFieldDto else { fatalError() }
                viewModels.append(MoneyViewModel(dto: dto))
            case .picker:
                guard let dto = fieldDto as? PickerFieldDto else { fatalError() }
                viewModels.append(PickerViewModel(dto: dto))
            case .slider:
                fatalError()
            case .switcher:
                guard let dto = fieldDto as? SwitchFieldDto else { fatalError() }
                viewModels.append(SwitchViewModel(dto: dto))
            case .undef:
                fatalError()
            }
        }
    }
}
