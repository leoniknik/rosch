//
//  AppDelegate.swift
//  Roschat
//
//  Created by Кирилл Володин on 16/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
        
        NVActivityIndicatorView.DEFAULT_TYPE = .orbit
        NVActivityIndicatorView.DEFAULT_COLOR = .purpleyTwo
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = createLoginViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func createLoginViewController() -> UIViewController {
        let model = LoginPresentationModel()
        let controller = LoginViewController(model: model)
        return controller
    }

}

