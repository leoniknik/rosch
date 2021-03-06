//
//  StyleViewController.swift
//  Roschat
//
//  Created by Кирилл Володин on 18/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

class StyleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var model: StyleSettingsPresentationModel = StyleSettingsPresentationModel()
    
    let styleCellId = "\(StyleCell.self)"
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.backgroundBlack
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: styleCellId, bundle: nil), forCellReuseIdentifier: styleCellId)
    }
    
    func createStyleField(_ tableView: UITableView, model: StyleViewModel, indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: styleCellId) as? StyleCell
            else { return UITableViewCell() }
        
        cell.configure(model: model)
        cell.delegate = self
        cell.id = indexPath.row
        cell.selectionStyle = .none
        return cell
    }

}

extension StyleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.styles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return createStyleField(tableView, model: model.styles[indexPath.row], indexPath: indexPath)
    }
}

extension StyleViewController: StyleCellDelegate {
    func styleTapped(id: Int) {
        
        if id == 2 {
            let alertController = UIAlertController(title: "Функция недоступна", message: "Функция находится в разработке", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController,animated: true)
            return
        }
        
        model.styles[id].selected = true
        for (index, _) in model.styles.enumerated() {
            if index != id {
                model.styles[index].selected = false
            }
        }
        tableView.reloadData()
        
        switch id {
        case 0:
            ServiceLayer.shared.dialogStyle = .normal
        case 1:
            ServiceLayer.shared.dialogStyle = .gopnik
        case 2:
            ServiceLayer.shared.dialogStyle = .normal
        default:
            break
        }
        
    }
}
