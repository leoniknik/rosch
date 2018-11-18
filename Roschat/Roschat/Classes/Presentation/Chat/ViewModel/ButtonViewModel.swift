//
//  ButtonViewModel.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class ButtonViewModel: FieldViewModel {
    var title: String
    var completion: (()->())?
    init(title: String, completion: (()->())?) {
        self.title = title
        self.completion = completion
        super.init()
    }
}
