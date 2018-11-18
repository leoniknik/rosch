//
//  ButtonCell.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    
    weak var delegate: FormViewControllerButtonDelegate?
    var model: ButtonViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.backgroundColor = UIColor.backgroundBlack
        confirmButton.layer.cornerRadius = 20
        confirmButton.clipsToBounds = true
        setTitle(title: "Далее")
        confirmButton.backgroundColor = .white
    }
    
    func setTitle(title: String) {
        let attrString = NSAttributedString(
            string: title,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.purpleyTwo,
                NSAttributedString.Key.font: UIFont.textStyle9
            ])
        confirmButton.setAttributedTitle(attrString, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: ButtonViewModel, delegate: FormViewControllerButtonDelegate) {
        self.delegate = delegate
        self.setTitle(title: model.title)
        self.model = model
    }
    
}
