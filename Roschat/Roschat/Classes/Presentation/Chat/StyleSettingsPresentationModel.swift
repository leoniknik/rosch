//
//  StyleSettingsPresentationModel.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 18/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

class StyleSettingsPresentationModel {
    var styles: [StyleViewModel]
    
    init() {
        self.styles = [StyleViewModel]()
        let st1 = StyleViewModel(selected: true, image: #imageLiteral(resourceName: "triangle"), title: "Бизнесмен", text: "fjrefbhjb")
        let st2 = StyleViewModel(selected: false, image: #imageLiteral(resourceName: "triangle"), title: "гопник", text: "fjrefbhjb")
        let st3 = StyleViewModel(selected: false, image: #imageLiteral(resourceName: "triangle"), title: "татата", text: "fjrefbhjb")
        self.styles = [st1, st2, st3]
    }
}
