//
//  ChatPresentationModel.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation

enum MessageType {
    case inDoc
    case outDoc
    case inText
    case outText
    case inForm
    case outForm
    case inImage
    case outImage
    case inUrl
    case outUrl
}

class ChatMessageModel {
    var type: MessageType!
}

class ChatTextMessageModel: ChatMessageModel {
    var text: String
    
    init(text: String) {
        self.text = text
    }
}

class ChatFormMessageModel: ChatMessageModel {
    var form: FormDto
    var complited: Bool
    var answers: UserMessageDto?
    
    init(form: FormDto, complited: Bool, answers: UserMessageDto? = nil) {
        self.form = form
        self.complited = complited
        self.answers = answers
    }
}

class ChatDocMessageModel: ChatMessageModel {
    var view: ViewDto
    
    init(view: ViewDto) {
        self.view = view
    }
}

class ChatPresentationModel {
    var messages = [ChatMessageModel]()
    var currentDialogState: DialogStateDto!
    var answerBuffer: UserMessageDto?
    var historyDtos: [HistoryDto] = [HistoryDto]()
    var buttonsModel: [ButtonViewModel] = [ButtonViewModel]()
    
    func configForDialogState() {
        if currentDialogState.type == .button {
            
        }
    }
    
    func parseHistory(historyDtos: [HistoryDto]) {
        if historyDtos.count == 0 {
            fatalError()
        } else if historyDtos.count > 1 {
            for i in 0..<historyDtos.count - 1 {
                let historyDto = historyDtos[i]
                if !historyDto.complited {
                    fatalError()
                } else {
                    _ = historyDto.botMessage
                    messages.append(contentsOf: getMessageModels(historyDto: historyDto))
                }
            }
        }
    }
    
    func addBotAnswer(botMessage:DialogStateDto) {
        if let lastHistoryDto = historyDtos.last {
            lastHistoryDto.complited = true
            lastHistoryDto.userMessage = answerBuffer
            lastHistoryDto.userTime = 0
        }
        let newHistoryDto = HistoryDto(id: botMessage.id, botTime: 0, botMessage: botMessage)
        currentDialogState = botMessage
        historyDtos.append(newHistoryDto)
        configForDialogState()
    }
    
    func sendAnswer() {
        
    }
    
    func getMessageModels(historyDto: HistoryDto) -> [ChatMessageModel] {
        let botMessage = historyDto.botMessage
        var botMessages = [ChatMessageModel]()
        
        botMessages.append(ChatTextMessageModel(text: botMessage.getMessage()))
        
        if botMessage.type == .form {
            if historyDto.complited {
                botMessages.append(ChatFormMessageModel(form: botMessage.formDto, complited: true, answers: historyDto.userMessage))
            } else {
                botMessages.append(ChatFormMessageModel(form: botMessage.formDto, complited: false))
            }
        }
        botMessages.append(contentsOf: getViewsMessages(botMessage:botMessage))
        return botMessages
    }
    
    func getViewsMessages(botMessage: DialogStateDto) -> [ChatMessageModel] {
        var messagesModels = [ChatMessageModel]()
        if let views = botMessage.views {
            for view in views {
                switch view.type {
                case .doc, .photo, .url:
                    let docModel = ChatDocMessageModel(view: view)
                    switch view.type {
                    case .doc:
                        docModel.type = .inDoc
                    case.photo:
                        docModel.type = .inImage
                    case.url:
                        docModel.type = .inUrl
                    default:
                        break
                    }
                    messagesModels.append(docModel)
                default:
                    break
                }
            }
        }
        return messagesModels
    }
    
}
