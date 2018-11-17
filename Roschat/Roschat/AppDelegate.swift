//
//  AppDelegate.swift
//  Roschat
//
//  Created by Кирилл Володин on 16/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //setupRootViewController()
        UIApplication.shared.statusBarStyle = .lightContent
        
//        ServiceLayer.shared.dialogStateService.getDialogState { result in
//            switch result {
//            case .success(let dto):
//                self.parseDialogState(dto: dto)
//            case .error(let error):
//                print(error)
//            }
//        }
        
                ServiceLayer.shared.dialogStateService.getDialogStateHistory { result in
                    switch result {
                    case .success(let historyDtos):
                        let lastHistoryDto = historyDtos.last!
                        let dialogstate = lastHistoryDto.botMessage
                        self.parseDialogState(dto: dialogstate)
                    case .error(let error):
                        print(error)
                    }
                }

        return true
    }
    
    func parseDialogState(dto: DialogStateDto) {
        print(dto.id)
        print(dto.getMessage())
        
        if dto.type == .form {
            var cnt = self.createFormViewController(dto: dto.formDto)
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let navController = self.setupNavigationViewController()
            navController.viewControllers.append(cnt)
            self.window?.rootViewController = navController
            self.window?.makeKeyAndVisible()
        }
        
        if let views = dto.views {
            for i in views {
                print(i);
            }
        }
        
        if dto.type == .button {
            var button = dto.buttons.first!
            let endpoint = button.endpoint
            let id = button.id
            ServiceLayer.shared.buttonActionService.sendButtonAction(endpoint: endpoint, buttonID: id, completion: { result in
                switch result {
                case .success(let dto):
                    self.parseDialogState(dto: dto)
                case .error(let error):
                    print(error)
                }
            })
        }
    }
    
    private func setupRootViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navController = setupNavigationViewController()
        let controller = UIViewController()
        
        navController.viewControllers.append(controller)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    private func setupNavigationViewController() -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.isTranslucent = false
        return navController
    }

    
    private func createChatViewController() -> UIViewController {
        let model = ChatPresentationModel()
        let controller = ChatViewController(model: model)
        return controller
    }
    
    private func createFormViewController(dto: FormDto) -> UIViewController {
        let model = FormPresentationModel(dto: dto)
        let controller = FormViewController(model: model)
        return controller
    }

}

