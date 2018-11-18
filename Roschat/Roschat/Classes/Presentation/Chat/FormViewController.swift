//
//  FormViewController.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let switchCellId = "\(SwitchCell.self)"
    let inputCellId = "\(TextCell.self)"
    let infoCellId = "\(InfoCell.self)"
    let dateCellId = "\(DateCell.self)"
    let pickerCellId = "\(PickerCell.self)"
    let buttonCellId = "\(ButtonCell.self)"
    let moneyCellId = "\(MoneyCell.self)"
    let sliderCellId = "\(SliderCell.self)"
    
    
    let model: FormPresentationModel
    
    init(model: FormPresentationModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavBar()
        self.navigationItem.title = "Форма"
        addСloseButton()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.backgroundBlack
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: switchCellId, bundle: nil), forCellReuseIdentifier: switchCellId)
        tableView.register(UINib(nibName: inputCellId, bundle: nil), forCellReuseIdentifier: inputCellId)
        tableView.register(UINib(nibName: infoCellId, bundle: nil), forCellReuseIdentifier: infoCellId)
        tableView.register(UINib(nibName: dateCellId, bundle: nil), forCellReuseIdentifier: dateCellId)
        tableView.register(UINib(nibName: pickerCellId, bundle: nil), forCellReuseIdentifier: pickerCellId)
        tableView.register(UINib(nibName: buttonCellId, bundle: nil), forCellReuseIdentifier: buttonCellId)
        tableView.register(UINib(nibName: moneyCellId, bundle: nil), forCellReuseIdentifier: moneyCellId)
    }
    
    func createSwitchField(_ tableView: UITableView, model: FieldViewModel) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: switchCellId) as? SwitchCell,
            let model = model as? SwitchViewModel
            else { return UITableViewCell() }
        
        cell.configure(model: model)
        cell.selectionStyle = .none
        return cell
    }
    
    func createInputField(_ tableView: UITableView, model: FieldViewModel) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: inputCellId) as? TextCell,
            let model = model as? InputViewModel
            else { return UITableViewCell() }
        
        cell.configure(model: model)
        cell.selectionStyle = .none
        return cell
    }
    
    func createInfoField(_ tableView: UITableView, model: FieldViewModel) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: infoCellId) as? InfoCell,
            let model = model as? InfoViewModel
            else { return UITableViewCell() }
        
        cell.configure(model: model)
        cell.selectionStyle = .none
        return cell
    }
    
    func createDateField(_ tableView: UITableView, model: FieldViewModel) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: dateCellId) as? DateCell,
            let model = model as? DateViewModel
            else { return UITableViewCell() }
        
        cell.configure(model: model)
        cell.selectionStyle = .none
        return cell
    }
    
    func createPickerField(_ tableView: UITableView, model: FieldViewModel) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: pickerCellId) as? PickerCell,
            let model = model as? PickerViewModel
            else { return UITableViewCell() }
        
        cell.configure(model: model)
        cell.selectionStyle = .none
        return cell
    }
    
    func createButtonField(_ tableView: UITableView, model: FieldViewModel) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: buttonCellId) as? ButtonCell,
            let model = model as? ButtonViewModel
            else { return UITableViewCell() }
        
        cell.configure(model: model)
        cell.selectionStyle = .none
        return cell
    }
    
    func createMoneyField(_ tableView: UITableView, model: FieldViewModel) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: moneyCellId) as? MoneyCell,
            let model = model as? MoneyViewModel
            else { return UITableViewCell() }
        
        cell.configure(model: model)
        cell.selectionStyle = .none
        return cell
    }
    
    func createSliderField(_ tableView: UITableView, model: FieldViewModel) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: sliderCellId) as? SliderCell,
            let model = model as? SliderViewModel
            else { return UITableViewCell() }
        
        cell.configure(model: model)
        cell.selectionStyle = .none
        return cell
    }
}

extension FormViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = model.viewModels[indexPath.row]
        switch viewModel.type {
        case .switchType:
            return createSwitchField(tableView, model: viewModel)
        case .input:
            return createInputField(tableView, model: viewModel)
        case .info:
            return createInfoField(tableView, model: viewModel)
        case .date:
            return createDateField(tableView, model: viewModel)
        case .picker:
            return createPickerField(tableView, model: viewModel)
        case .button:
            return createButtonField(tableView, model: viewModel)
        case .money:
            return createMoneyField(tableView, model: viewModel)
        case .slider:
            return createSliderField(tableView, model: viewModel)
            
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = model.viewModels[indexPath.row]
        switch viewModel.type {
        case .switchType:
            return 60
        case .input:
            return 80
        case .info:
            return 50
        case .date:
            return 80
        case .picker:
            return 80
        case .button:
            return 97
        case .money:
            return 81
        case .slider:
            return 104
        }
    }
}
