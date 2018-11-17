//
//  TextCell.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topView.backgroundColor = .backgroundBlack
        mainView.backgroundColor = .black
        
        titleLabel.font = .textStyle3
        titleLabel.textColor = .white
        
        inputTextField.font = .textStyle5
        inputTextField.textColor = .white
        inputTextField.attributedPlaceholder = NSAttributedString(
            string: "Введите данные",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.brownGrey])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: InputViewModel) {
        
    }
}
