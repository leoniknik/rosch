//
//  UIViewController+SetupNavBar.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupNavBar() {
        navigationController?.navigationBar.barTintColor = .black82
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .navPurple
    }
    
    func addBackButton() {
        let backImage = #imageLiteral(resourceName: "back")
        backImage.withRenderingMode(.alwaysTemplate)
        let backButton = UIBarButtonItem(image: backImage, style: .done, target: self, action: #selector(goBack))
        navigationItem.setLeftBarButton(backButton, animated: false)
    }
    
    func addСloseButton() {
        let closeImage = #imageLiteral(resourceName: "close")
        closeImage.withRenderingMode(.alwaysTemplate)
        let closeButton = UIBarButtonItem(image: closeImage, style: .done, target: self, action: #selector(close))
        navigationItem.setLeftBarButton(closeButton, animated: false)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}

