//
//  InDocCell.swift
//  Roschat
//
//  Created by Кирилл Володин on 18/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit
import Kingfisher

class InDocCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var docImage: UIImageView!
    
    var model: ViewDto!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.textStyle14
        
        mainView.layer.cornerRadius = 17.5
        mainView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(model: ChatDocMessageModel) {
        if model.view.type == .url {
            var urlModel = model.view as! UrlViewDto
            titleLabel.text = urlModel.text
            docImage.kf.setImage(with: URL(string: urlModel.image)!)
        }
        if model.view.type == .doc {
            var docModel = model.view as! DocViewDto
            titleLabel.text = docModel.text
        }
    }
    
    var openFormAction: ((ChatFormMessageModel)->())?
    var modelForm: ChatFormMessageModel?
    func config(model: ChatFormMessageModel) {
        titleLabel.text = "Форма номер \(model.form.id)"
        docImage.image = UIImage(named: "group")
    }
}
