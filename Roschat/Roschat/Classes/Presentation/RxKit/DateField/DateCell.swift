//
//  DateCell.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class DateCell: UITableViewCell {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UITextField!
    
    @IBOutlet weak var datePickerButton: UIButton!
    
    let datePicker = UIDatePicker()
    var isPickerEnabled = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topView.backgroundColor = UIColor.backgroundBlack
        mainView.backgroundColor = .black
        
        titleLabel.font = .textStyle3
        titleLabel.textColor = .white
        titleLabel.text = "Введите дату"
        
        dateLabel.font = .textStyle5
        dateLabel.textColor = .white
        dateLabel.attributedPlaceholder = NSAttributedString(
            string: "Дата",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.brownGrey])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: DateViewModel) {
        isPickerEnabled = model.editable
        guard let date = model.value else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateLabel.text = formatter.string(from: date)
    }
    
    @IBAction func pickDate(_ sender: UIButton) {
        guard isPickerEnabled else { return }
        datePicker.datePickerMode = .date
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateLabel.inputAccessoryView = toolbar
        dateLabel.inputView = datePicker
        dateLabel.becomeFirstResponder()
    }
    
    @objc func donedatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateLabel.text = formatter.string(from: datePicker.date)
        endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        endEditing(true)
        dateLabel.text = ""
    }
    
}
