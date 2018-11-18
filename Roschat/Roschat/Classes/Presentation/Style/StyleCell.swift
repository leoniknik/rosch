//
//  StyleCell.swift
//  Roschat
//
//  Created by Кирилл Володин on 18/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

protocol StyleCellDelegate: class {
    func styleTapped(id: Int)
}

class StyleCell: UITableViewCell {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var background: UIView!
    
    @IBOutlet weak var avatarView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var selectButton: UIButton!
    
    var id: Int?
    
    weak var delegate: StyleCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: StyleViewModel) {
        topView.backgroundColor = UIColor.backgroundBlack
        background.backgroundColor = .black
        
        avatarView.image = model.image
        titleLabel.text = model.title
        infoLabel.text = model.text
        
        titleLabel.textColor = .white
        infoLabel.textColor = .white
        
        selectButton.layer.cornerRadius = 16
        selectButton.clipsToBounds = true
        selectButton.backgroundColor = .clear
        selectButton.layer.borderWidth = 1.0
        
        if model.selected {
            selectButton.layer.borderColor = UIColor.white.cgColor
            
            let attrString = NSAttributedString(
                string: "Установлен",
                attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont.textStyle9
                ])
            selectButton.setAttributedTitle(attrString, for: .normal)
            
        } else {
            let attrString = NSAttributedString(
                string: "Установить",
                attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.purpleyTwo,
                    NSAttributedString.Key.font: UIFont.textStyle9
                ])
            selectButton.setAttributedTitle(attrString, for: .normal)
            selectButton.layer.borderColor = UIColor.purpleyTwo.cgColor
        }
    }
    
    @IBAction func selectTapped(_ sender: UIButton) {
        guard let id = id else { return }
        delegate?.styleTapped(id: id)
    }
    
}
