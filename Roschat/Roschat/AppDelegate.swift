//
//  AppDelegate.swift
//  Roschat
//
//  Created by Кирилл Володин on 16/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Alamofire
import SafariServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
        downloadFile()
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
    
    private func downloadFile() {
//        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)

//        Alamofire.download(
//            "http://192.168.0.2:8000/api/test/document",
//            method: .get,
//            parameters: [:] as Parameters,
//            encoding: JSONEncoding.default,
//            headers: nil,
//            to: destination).downloadProgress(closure: { (progress) in
//                print(progress)
//            }).response(completionHandler: { (DefaultDownloadResponse) in
//                print(DefaultDownloadResponse)
//            })
        
//        Alamofire.download("http://192.168.0.2:8000/api/test/document", method: .get, parameters: nil, encoding: JSONEncoding.default, to: destination).responseJSON { response in
//            if response.result.error == nil {
//                completion?(JSON(response.result.value as? NSDictionary ?? [:]))
//            } else {
//                print(#function, error)
//            }
//        }
        
        
        
    }

}

