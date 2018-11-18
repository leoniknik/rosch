//
//  StyleViewModel.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 18/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class StyleViewModel {
    var selected: Bool
    var image: UIImage
    var title: String
    var text: String
    
    init(selected: Bool,
         image: UIImage,
         title: String,
         text: String) {
        self.selected = selected
        self.image = image
        self.title = title
        self.text = text
    }
}
