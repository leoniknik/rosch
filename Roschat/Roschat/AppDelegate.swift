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
        setupRootViewController()
        UIApplication.shared.statusBarStyle = .lightContent
        
        return true
    }
    
    private func setupRootViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navController = setupNavigationViewController()
        let controller = createFormViewController()
        
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
    
    private func createFormViewController() -> UIViewController {
        let model = FormPresentationModel()
        model.viewModels.append(InfoViewModel(type: .info))
        model.viewModels.append(DateViewModel(type: .date))
        model.viewModels.append(SwitchViewModel(type: .switchType))
        model.viewModels.append(InputViewModel(type: .input))
        model.viewModels.append(SwitchViewModel(type: .switchType))
        model.viewModels.append(PickerViewModel(type: .picker))
        model.viewModels.append(InputViewModel(type: .input))
        model.viewModels.append(InfoViewModel(type: .info))
        model.viewModels.append(ButtonViewModel(type: .button))
        let controller = FormViewController(model: model)
        return controller
    }

}

