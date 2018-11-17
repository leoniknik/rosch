//
//  PickerCell.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class PickerCell: UITableViewCell {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerLabel: UITextField!
    
    let itemPicker = UIPickerView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topView.backgroundColor = UIColor.backgroundBlack
        mainView.backgroundColor = .black
        
        titleLabel.font = .textStyle3
        titleLabel.textColor = .white
        titleLabel.text = "Выберите опцию"
        
        pickerLabel.font = .textStyle5
        pickerLabel.textColor = .white
        pickerLabel.attributedPlaceholder = NSAttributedString(
            string: "Опция",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.brownGrey])
        
        //TODO: выпилить потом и вынести в контроллер и вьюмодель
        itemPicker.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(model: PickerViewModel) {
        
    }
    
    @IBAction func pickItem(_ sender: UIButton) {
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        pickerLabel.inputAccessoryView = toolbar
        pickerLabel.inputView = itemPicker
        pickerLabel.becomeFirstResponder()
    }
    
    @objc func donedatePicker() {
        print(itemPicker.selectedRow(inComponent: 0))
//        pickerLabel.text = formatter.string(from: itemPicker.)
        endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        endEditing(true)
        pickerLabel.text = ""
    }
    
}

extension PickerCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
}
