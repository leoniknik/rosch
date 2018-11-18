//
//  MoneyCell.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 18/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class MoneyCell: UITableViewCell {

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
        
        inputTextField.font = .textStyle12
        inputTextField.textColor = .white
        inputTextField.attributedPlaceholder = NSAttributedString(
            string: "0 Р",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.brownGrey])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: MoneyViewModel) {
        titleLabel.text = model.label
        //currency
        inputTextField.isEnabled = model.editable
    }
    
}
