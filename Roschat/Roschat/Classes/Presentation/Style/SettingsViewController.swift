//
//  SettingsViewController.swift
//  Roschat
//
//  Created by Кирилл Володин on 18/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var sectionView: UIView!
    @IBOutlet weak var catalogLabel: UILabel!
    @IBOutlet weak var chooseStyleLabel: UILabel!
    
    @IBOutlet weak var exitView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Настройка"
        setupNavBar()
        addBackButton()
        
    }
    
    func setupUI() {
        
    }

}
