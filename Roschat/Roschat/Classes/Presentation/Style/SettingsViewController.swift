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

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Настройки"
        setupNavBar()
        addBackButton()
        setupUI()
    }
    
    func setupUI() {
        sectionView.backgroundColor = .black
        view.backgroundColor = .backgroundBlack
        exitView.backgroundColor = .black
    }

    @IBAction func styleTapped(_ sender: Any) {
        let viewcontroller = StyleViewController()
        navigationController?.pushViewController(viewcontroller, animated: true)
    }
}
