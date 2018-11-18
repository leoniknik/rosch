//
//  InTextMessageCell.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class InTextMessageCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var textMessageLabel: UILabel!
    @IBOutlet weak var textBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImage.layer.cornerRadius = avatarImage.frame.width / 2.0
        avatarImage.clipsToBounds = true
        
        textMessageLabel.textColor = UIColor.black
        textMessageLabel.font = UIFont.textStyle12
        
        textBackgroundView.layer.cornerRadius = 17.5
        textBackgroundView.clipsToBounds = true
        textBackgroundView.backgroundColor = UIColor.paleLilac
        contentView.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(model: ChatTextMessageModel) {
        self.textMessageLabel.text = model.text
    }
    
}
