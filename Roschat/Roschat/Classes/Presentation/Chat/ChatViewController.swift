//
//  ChatViewController.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    let model: ChatPresentationModel
    
    init(model: ChatPresentationModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addInfoButton()
        setupNavBar()
        navigationItem.title = "Чат"
    }
    
    func addInfoButton() {
        let infoImage = #imageLiteral(resourceName: "info")
        infoImage.withRenderingMode(.alwaysTemplate)
        let infoButton = UIBarButtonItem(image: infoImage, style: .done, target: self, action: #selector(openSettings))
        navigationItem.setRightBarButton(infoButton, animated: false)
    }
    
    @objc func openSettings() {
        
    }

}
