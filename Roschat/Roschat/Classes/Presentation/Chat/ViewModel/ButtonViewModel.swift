//
//  ButtonViewModel.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

enum ButtonViewModelType {
    case sendPhoto
    case sendDoc
    case navButton
    case sendForm
}

class ButtonViewModel: FieldViewModel {
    var buttonType: ButtonViewModelType
    var title: String
    init(type: ButtonViewModelType, title: String) {
        self.buttonType = type
        self.title = title
        super.init()
    }
}
