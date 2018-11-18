//
//  ChatViewController.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit
import ChameleonFramework
import SafariServices
import Alamofire
import NVActivityIndicatorView

class ChatViewController: UIViewController {

    private let inTextMessageCell = "\(InTextMessageCell.self)"
    private let myTextMessageCell = "\(MyTextMessageCell.self)"
    private let inDocCell = "\(InDocCell.self)"
    
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var buttonStack: UIStackView!
    
    var isFirstReload: Bool = true
    
    let model: ChatPresentationModel
    
    init(model: ChatPresentationModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addInfoButton()
        setupNavBar()
        navigationItem.title = "Чат"
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.layoutIfNeeded()
    }
    
    func setupTableView() {
        view.backgroundColor = UIColor.backgroundBlack
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.backgroundBlack
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: inTextMessageCell, bundle: nil), forCellReuseIdentifier: inTextMessageCell)
        tableView.register(UINib(nibName: myTextMessageCell, bundle: nil), forCellReuseIdentifier: myTextMessageCell)
       
        tableView.register(UINib(nibName: inDocCell, bundle: nil), forCellReuseIdentifier: inDocCell)
    }
    
//    func setupOneButton() {
//        oneButton.setTitleColor(UIColor.purpleyTwo, for: .normal)
//        oneButton.layer.cornerRadius = 20
//        oneButton.clipsToBounds = true
//        oneButton.backgroundColor = .white
//
//        let attrString = NSAttributedString(
//            string: "Далее",
//            attributes: [
//                NSAttributedString.Key.foregroundColor: UIColor.purpleyTwo,
//                NSAttributedString.Key.font: UIFont.textStyle9
//            ])
//        oneButton.setAttributedTitle(attrString, for: .normal)
//
//        buttonStack.addArrangedSubview(setupAutoButton())
//        buttonStack.addArrangedSubview(setupAutoButton())
//    }
    
    func setupButtons(buttons: [ButtonDto]) {
        for oldButton in buttonStack.arrangedSubviews {
            buttonStack.removeArrangedSubview(oldButton)
            oldButton.removeFromSuperview()
        }
        if model.currentDialogState.type != .form {
            for i in 0..<buttons.count {
                buttonStack.addArrangedSubview( setupAutoButton(tag: i, buttonTitle: buttons[i].text))
            }
        }
    }
    
    func setupAutoButton(tag: Int, buttonTitle: String) -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor.purpleyTwo, for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = .white
        let attrString = NSAttributedString(
            string: buttonTitle,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.purpleyTwo,
                NSAttributedString.Key.font: UIFont.textStyle9
            ])
        button.setAttributedTitle(attrString, for: .normal)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.tag = tag
//        button.titleLabel?.numberOfLines = 1;
//        button.titleLabel?.adjustsFontSizeToFitWidth = true;
//        button.titleLabel?.lineBreakMode = .byClipping;
        button.addTarget(self, action: #selector(navButtonPressed(_:)), for: .touchUpInside)
        return button
    }
    
    @objc func navButtonPressed(_ sender: UIButton) {
        model.navButtonPressed(tag: (sender as? UIButton)?.tag ?? 0)
    }
    
    func addInfoButton() {
        let infoImage = #imageLiteral(resourceName: "info")
        infoImage.withRenderingMode(.alwaysTemplate)
        let infoButton = UIBarButtonItem(image: infoImage, style: .done, target: self, action: #selector(openSettings))
        navigationItem.setRightBarButton(infoButton, animated: false)
    }
    
    @objc func openSettings() {
        let viewcontroller = SettingsViewController()
        navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    func rowTaped(_ id: Int) {
        
        guard let type = model.messages[id].type else {
            return
        }
        
        if type == .inUrl {
            let m = model.messages[id] as! ChatDocMessageModel
            let m2 = m.view as! UrlViewDto
            let url = URL(string: m2.url)!
            var vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
        
        if type == .inForm {
            let  messageModel  = model.currentDialogState.formDto
            var formPresentationModel = FormPresentationModel(dto: messageModel!)
            let contoller = FormViewController(model: formPresentationModel)
            formPresentationModel.viewModels.append( ButtonViewModel(title: "Далее", completion: {
                [weak self] in self?.sendForm()
            }))
            navigationController?.pushViewController(contoller, animated: true)
        }
        if type == .inDoc {
            let m = model.messages[id] as! ChatDocMessageModel
            let m2 = m.view as! DocViewDto
            
            var urlS = "http://192.168.0.11/api/test/document?id=\(m2.fileId)"
            
            let url = URL(string: urlS)!
            var vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
    }
}




extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messageModel = model.messages[indexPath.row]
        guard let messageType = messageModel.type else { return UITableViewCell() }
        switch messageType {
        case .inDoc:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: inDocCell)
                as? InDocCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.config(model: messageModel as! ChatDocMessageModel)
            return cell
        case .outDoc:
            break
        case .inText:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: inTextMessageCell)
                as? InTextMessageCell else { return UITableViewCell() }
            cell.config(model: messageModel as! ChatTextMessageModel)
            cell.selectionStyle = .none
            return cell
        case .outText:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: myTextMessageCell)
                as? MyTextMessageCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.config(model: messageModel as! ChatTextMessageModel)
            return cell
        case .inForm:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: inDocCell)
                as? InDocCell else { return UITableViewCell() }
            cell.modelForm = messageModel as! ChatFormMessageModel
            cell.config(model: messageModel as! ChatFormMessageModel)
            cell.selectionStyle = .none
            return cell
        case .outForm:
            break
        case .inImage:
            break
        case .outImage:
            break
        case .inUrl:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: inDocCell)
                as? InDocCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.config(model: messageModel as! ChatDocMessageModel)
            return cell
        case .outUrl:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowTaped(indexPath.row)
    }
    
    func sendForm() {
        navigationController?.popViewController(animated: true)
        model.navButtonPressed(tag: 0)
    }
    
}

extension ChatViewController: ChatPresentationModelDelegate {
    func blockScreen() {
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    }
    
    func unblockscreen() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    
    func reloadData() {
        if isFirstReload {
            isFirstReload = false
            tableView.reloadData()
            tableView.layoutIfNeeded()
            tableView.scrollToRow(at: IndexPath(row: model.messages.count-1, section: 0), at: .bottom, animated: false)
        } else {
            isFirstReload = false
            tableView.reloadData()
            tableView.layoutIfNeeded()
            tableView.scrollToRow(at: IndexPath(row: model.messages.count-1, section: 0), at: .bottom, animated: true)
        }

    }
    
    func setupNavButtons(buttonsDtos: [ButtonDto]) {
        setupButtons(buttons: buttonsDtos)
    }
}


//        guard let url = URL(string: "http://192.168.0.2:8000/api/user/photo") else { return }
//        let sf = SFSafariViewController(url: url)
//        present(sf, animated: true)



//    /api/user/photo
//
//    body multipart
//    {
//    "file":
//    }

//func requestWith() {
//
//    let url = "http://192.168.0.2:8000/api/user/photo"
//
//    let headers: HTTPHeaders = [
//        "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhY2Nlc3MiLCJqdGkiOiIxIiwiYXVkIjoiVVNFUiIsImV4cCI6MTU0MjUxOTAyN30.ZpVPcrMyza1gmqA889tMgt4i_A2bnCR_oqeFPGORLz5_n3nNhQq266cFdlRvvmTb78peK9-W9W_uaoTRdoftHg",
//        "Content-type": "multipart/form-data"
//    ]
//
//    guard let imageData = #imageLiteral(resourceName: "bot").pngData() else { return }
//
//    //        let params = [
//    //            "file": imageData
//    //        ] as [String: String]
//
//    Alamofire.upload(multipartFormData: { (multipartFormData) in
//        multipartFormData.append(imageData, withName: "file", fileName: "bot.png", mimeType: "image/png")
//        //                multipartFormData.append(imageData, withName: "file")
//        //            for (key, value) in parameters {
//        //                if let data = value.data(using: .utf8) {
//        //                multipartFormData.append(data, withName: key)
//        //                }
//        //            }
//        //            if let data = imageData {
//        //                multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
//        //            }
//
//    }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
//        switch result{
//        case .success(let upload, _, _):
//            upload.responseJSON { response in
//                print("Succesfully uploaded")
//                if let err = response.error{
//                    print(err)
//                    return
//                }
//            }
//        case .failure(let error):
//            print("Error in upload: \(error.localizedDescription)")
//        }
//    }
//}


//    guard let parameters = config.parameters as? [String: String] else {
//    completionHandler?(Result.error("Не верные параметры"))
//    return
//    }
//
//    Alamofire.upload(multipartFormData: { (multipartFormData) in
//    for (key, value) in parameters {
//    if let data = value.data(using: .utf8) {
//    multipartFormData.append(data, withName: key)
//    }
//    }
//    guard let path = Constants.recordsPath?.appendingPathComponent("Запись 0.wav") else { return }
//    //            multipartFormData.append(config.file.filePath, withName: config.file.parameterName, fileName: config.file.fileName, mimeType: config.file.mimeType)
//    multipartFormData.append(path, withName: "Content", fileName: "Запись 0.wav", mimeType: "audio/wav")
