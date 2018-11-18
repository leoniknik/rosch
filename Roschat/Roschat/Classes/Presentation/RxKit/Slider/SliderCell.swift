//
//  SliderCell.swift
//  Roschat
//
//  Created by Aleksander Evtuhov on 18/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class SliderCell: UITableViewCell {

    @IBOutlet weak var topView: UIView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
   
    var title = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topView.backgroundColor = .backgroundBlack
        
        titleLabel.font = .textStyle11
        titleLabel.textColor = .white
        
        maxLabel.font = .textStyle11
        maxLabel.textColor = .white
        
        minLabel.font = .textStyle11
        minLabel.textColor = .white
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func refreshTitle(){
        titleLabel.text = "\(title) : \(slider.value)"
    }
    
    func configure(model: SliderViewModel) {
        title = model.label
        slider.isEnabled = model.editable
        slider.maximumValue = Float(model.max)
        slider.minimumValue = Float(model.min)
        slider.value = Float(model.value)
        maxLabel.text = "\(model.max)"
        minLabel.text = "\(model.min)"
    }
    
}
