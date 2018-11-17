//
//  SwitchCell.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit
import ChameleonFramework

class SwitchCell: UITableViewCell {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var valueSwitch: UISwitch!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topView.backgroundColor = UIColor.backgroundBlack
        mainView.backgroundColor = UIColor.black
        
        let gradientColor = GradientColor(.leftToRight, frame: valueSwitch.frame, colors: [UIColor.lightUrple, UIColor.bluePurple])
        valueSwitch.tintColor = gradientColor
        valueSwitch.onTintColor = gradientColor
        
        descriptionLabel.font = UIFont.textStyle4
        descriptionLabel.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: SwitchViewModel) {
        
    }
    
}
