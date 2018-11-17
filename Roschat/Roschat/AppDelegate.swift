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
        
        var json = """
{
"fields":[
   {
      "name":"date_picker",
      "label":"Выберите дату",
      "hint":null,
      "enabled":true,
      "type":"DATE_PICKER",
      "value":1542461435324
   },
   {
      "name":"label_field",
      "label":"какой то лейбл",
      "hint":null,
      "enabled":true,
      "type":"LABEL"
   },
   {
      "name":"picker",
      "label":"picker",
      "hint":null,
      "enabled":true,
      "type":"PICKER",
      "value":null,
      "variants":[
         "value1",
         "value2",
         "value3"
      ]
   },
   {
      "name":"sw",
      "label":"switch",
      "hint":null,
      "enabled":true,
      "type":"SWITCH",
      "value":true
   }
]

}
   
"""
        let data = json.data(using: .utf8)!
        guard let a = FormDto(data: data) else {
            return UIViewController()
        }
        let model = FormPresentationModel(dto: a)
        let controller = FormViewController(model: model)
        return controller
    }

}

