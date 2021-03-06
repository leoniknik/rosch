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
        let selStyle = ServiceLayer.shared.dialogStyle
        
        let st1 = StyleViewModel(
            selected: (selStyle == .normal),
            image: #imageLiteral(resourceName: "delo"),
            title: "Бизнесмен",
            text: "Деловой стиль общения, к которому вы привыкли."
        )
        let st2 = StyleViewModel(
            selected: (selStyle == .gopnik),
            image: #imageLiteral(resourceName: "gop"),
            title: "Гопник",
            text: "Дерзкий стиль общения, для четких парней."
        )
        let st3 = StyleViewModel(
            selected: (selStyle == .girl),
            image: #imageLiteral(resourceName: "nya"),
            title: "Ламповая тян",
            text: "Вежливый стиль общения, которому вы захотите оставить деньги."
        )
        self.styles = [st1, st2, st3]
    }
}
