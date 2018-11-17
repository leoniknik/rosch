//
//  InfoCell.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        infoLabel.textColor = .white
        infoLabel.font = UIFont.textStyle
        mainView.backgroundColor = UIColor.backgroundBlack
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: InfoViewModel) {
        
    }
    
}
