//
//  MyTextMessageCell.swift
//  Roschat
//
//  Created by Кирилл Володин on 18/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit
import ChameleonFramework

class MyTextMessageCell: UITableViewCell {

    @IBOutlet weak var textMessageLabel: UILabel!
    @IBOutlet weak var textBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textMessageLabel.textColor = .white
        textMessageLabel.font = UIFont.textStyle12
        
        textBackgroundView.layer.cornerRadius = 17.5
        textBackgroundView.clipsToBounds = true
        
        contentView.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        let gradientColor = GradientColor(.leftToRight, frame: textBackgroundView.frame, colors: [UIColor.lightUrple, UIColor.bluePurple])
        textBackgroundView.backgroundColor = gradientColor
    }
    
}
