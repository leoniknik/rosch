//
//  HistoryDto.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import SwiftyJSON

class HistoryDto {
    var id: Int
    var botTime: Int
    var botMessage: DialogStateDto
    
    var complited: Bool = false
    
    var userTime: Int!
    var userMessage: UserMessageDto!
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.botTime = json["botTime"].intValue
        guard let botMessage = DialogStateDto(json: json["botMessage"]) else { fatalError() }
        self.botMessage = botMessage
        
        if json["userTime"].int != nil {
            complited = true
            self.userTime = json["userTime"].intValue
            self.userMessage = UserMessageDto(json: json["userMessage"])
        }
    }
    
    init(id: Int, botTime: Int, botMessage: DialogStateDto) {
        self.id = id
        self.botTime = botTime
        self.botMessage = botMessage
    }
}
