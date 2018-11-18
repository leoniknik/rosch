//
//  InDocCell.swift
//  Roschat
//
//  Created by Кирилл Володин on 18/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class InDocCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var docImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.textStyle14
        
        mainView.layer.cornerRadius = 17.5
        mainView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
