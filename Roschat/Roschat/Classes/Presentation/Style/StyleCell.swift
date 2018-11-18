//
//  StyleCell.swift
//  Roschat
//
//  Created by Кирилл Володин on 18/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class StyleCell: UITableViewCell {

    @IBOutlet weak var avatarView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var selectButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: StyleViewModel) {
        avatarView.image = model.image
        titleLabel.text = model.title
        infoLabel.text = model.text
        
        if model.selected {
            
        } else {
            
        }
    }
    
}
