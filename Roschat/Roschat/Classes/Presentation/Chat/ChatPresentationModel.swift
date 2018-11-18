//
//  ChatPresentationModel.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import Foundation
import SafariServices
import SwiftyJSON


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
    var type: MessageType?
    init(type: MessageType) {
        self.type = type
    }
}

class ChatTextMessageModel: ChatMessageModel {
    var text: String
    
    init(text: String, type: MessageType) {
        self.text = text
        super.init(type: type)
    }
}

class ChatFormMessageModel: ChatMessageModel {
    var form: FormDto
    var complited: Bool
    var answers: UserMessageDto?
    
    init(form: FormDto, complited: Bool, type: MessageType, answers: UserMessageDto? = nil) {
        self.form = form
        self.complited = complited
        self.answers = answers
        super.init(type: type)
    }
}

class ChatDocMessageModel: ChatMessageModel {
    var view: ViewDto
    
    init(view: ViewDto, type: MessageType) {
        self.view = view
        super.init(type: type)
    }
}

protocol ChatPresentationModelDelegate: class {
    func setupNavButtons(buttonsDtos: [ButtonDto])
    func reloadData()
    func blockScreen()
    func unblockscreen()
}

class ChatPresentationModel {
    var messages = [ChatMessageModel]()
    var currentDialogState: DialogStateDto!
    var answerBuffer: UserMessageDto?

    var historyDtos: [HistoryDto] = [HistoryDto]()
    var buttonsModel: [ButtonViewModel] = [ButtonViewModel]()
    weak var delegate: ChatPresentationModelDelegate?
    
    func configForDialogState() {
        if currentDialogState.type == .button {
            delegate?.setupNavButtons(buttonsDtos: currentDialogState.buttons)
        }
    }
    
    func getHistory(){
        delegate?.blockScreen()
        ServiceLayer.shared.dialogStateService.getDialogStateHistory {[weak self] result in
            switch result {
            case .success(let historyDtos):
                self?.parseHistory(historyDtos: historyDtos)
            case .error(let error):
                print(error)
            }
            self?.delegate?.unblockscreen()
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
                    var botMessage = historyDto.botMessage
                    messages.append(contentsOf: getMessageModels(historyDto: historyDto))
                    processUserMessage(historyDto: historyDto)
                    
                }
            }
        }
        guard let lastMessage = historyDtos.last?.botMessage else { fatalError() }
        addLastBotHistState(botMessage: lastMessage)
    }
    
    func processUserMessage( historyDto: HistoryDto) {
        let botMessage = historyDto.botMessage
        switch botMessage.type {
        case .button:
            messages.append(ChatTextMessageModel(text: historyDto.userMessage.strValue, type: .outText))
        case .doc:
            messages.append(ChatTextMessageModel(text: historyDto.userMessage.strValue, type: .outText))
        case .form:
            messages.append(ChatTextMessageModel(text: "Форма заполнена", type: .outText))
        case.photo:
            messages.append(ChatTextMessageModel(text: historyDto.userMessage.strValue, type: .outText))
        case .text:
            messages.append(ChatTextMessageModel(text: historyDto.userMessage.strValue, type: .outText))
        default:
            break
        }
    }
    
    func addBotAnswer(botMessage:DialogStateDto) {
        
        if let lastHistoryDto = historyDtos.last {
            lastHistoryDto.complited = true
            lastHistoryDto.userMessage = answerBuffer
            lastHistoryDto.userTime = 0
            processUserMessage(historyDto: lastHistoryDto)
        }
        var newHistoryDto = HistoryDto(id: botMessage.id, botTime: 0, botMessage: botMessage)
        currentDialogState = botMessage
        historyDtos.append(newHistoryDto)
        addLastStateMessage(botMessage: botMessage)
        configForDialogState()
        delegate?.reloadData()
    }
    
    func addLastBotHistState(botMessage:DialogStateDto) {
        var newHistoryDto = HistoryDto(id: botMessage.id, botTime: 0, botMessage: botMessage)
        currentDialogState = botMessage
        historyDtos.append(newHistoryDto)
        addLastStateMessage(botMessage: botMessage)
        configForDialogState()
        delegate?.reloadData()
    }
    
    func navButtonPressed(tag: Int) {
        if currentDialogState.type == .button {
            let button = currentDialogState.buttons[tag]
            let endpoint = button.endpoint
            let id = button.id
            
            let answer = UserMessageDto(type: currentDialogState.type, strValue: button.text)
            answerBuffer = answer
            ServiceLayer.shared.buttonActionService.sendButtonAction(endpoint: endpoint, buttonID: id, completion: { result in
                switch result {
                case .success(let dto):
                    self.addBotAnswer(botMessage: dto)
                case .error(let error):
                    print(error)
                }
            })
        } else if currentDialogState.type == .form {
            
            let answer = UserMessageDto(type: currentDialogState.type, jsonValue: JSON())
            answerBuffer = answer
            
            ServiceLayer.shared.buttonActionService.sendButtonAction(endpoint: currentDialogState.endpoint!, buttonID: 0, completion: { result in
                switch result {
                case .success(let dto):
                    self.addBotAnswer(botMessage: dto)
                case .error(let error):
                    print(error)
                }
                
            })
        }
    }
    
    func addLastStateMessage(botMessage: DialogStateDto) {
        var botMessages = [ChatMessageModel]()
        
        botMessages.append(ChatTextMessageModel(text: botMessage.getMessage(), type: .inText))
        
        if botMessage.type == .form {
            
            let msg = ChatFormMessageModel(form: botMessage.formDto, complited: false, type: .inForm)
            botMessages.append(msg)
            
        }
        botMessages.append(contentsOf: getViewsMessages(botMessage:botMessage))
        
        messages.append(contentsOf: botMessages)
    }
    
    func getMessageModels(historyDto: HistoryDto) -> [ChatMessageModel] {
        var botMessage = historyDto.botMessage
        var botMessages = [ChatMessageModel]()

        botMessages.append(ChatTextMessageModel(text: botMessage.getMessage(), type: .inText))
        
        if botMessage.type == .form {
            if historyDto.complited {
                let msg = ChatFormMessageModel(form: botMessage.formDto, complited: true, type: .inForm, answers: historyDto.userMessage)
                botMessages.append(msg)
            } else {
                let msg = ChatFormMessageModel(form: botMessage.formDto, complited: false, type: .inForm)
                botMessages.append(msg)
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
                    var docModel = ChatDocMessageModel(view: view, type: .inDoc)
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
    
    func rowTaped(_ id: Int) {
        
        guard let type = messages[id].type else {
            return
        }
        
        if type == .inUrl {
            let m = messages[id] as! ChatDocMessageModel
            let m2 = m.view as! UrlViewDto
            let url = URL(string: m2.url)!
            var vc = SFSafariViewController(url: url)
            
        }
    }
    
}
