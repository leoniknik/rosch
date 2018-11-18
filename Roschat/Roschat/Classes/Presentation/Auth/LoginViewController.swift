//
//  LoginViewController.swift
//  Roschat
//
//  Created by Кирилл Володин on 17/11/2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit
import InputMask
import RxCocoa
import RxSwift
import NVActivityIndicatorView
import SafariServices
import SwiftMessages

final class LoginViewController: UIViewController, NVActivityIndicatorViewable {
    
    //UI
    @IBOutlet weak var enterBankLabel: UILabel!
    @IBOutlet weak var inputNumberCardLabel: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak private var cardNumberTextField: UITextField!
    @IBOutlet weak private var signInButton: UIButton!

    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var clientLabel: UILabel!
    
    @IBOutlet weak var cardimage: UIImageView!
    @IBOutlet weak var ourCardLabel: UILabel!
    
    var model: LoginPresentationModel
    
    private var maskedDelegate: MaskedTextFieldDelegate!
    private var disposeBag = DisposeBag()
    private var cardNumberSubject = PublishSubject<String>()
    private var activity: NVActivityIndicatorView!
    
    var otp: Int = 0
    var cardNumber: String = ""

    init(model: LoginPresentationModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupUI()
        validateForm()
        setupInputMask()
    }
    
    private func setupUI() {
        enterBankLabel.textColor = .white
        enterBankLabel.font = .textStyle7
        
        inputNumberCardLabel.textColor = .white
        inputNumberCardLabel.font = .textStyle10
        
        cardView.layer.cornerRadius = 8
        cardView.clipsToBounds = true
        
        separatorView.backgroundColor = .veryLightPink
        
        signInButton.layer.cornerRadius = 20
        signInButton.clipsToBounds = true
        signInButton.layer.borderWidth = 1.0
        signInButton.isEnabled = false
        signInButton.layer.borderColor = UIColor.veryLightPink.cgColor
        signInButton.setTitleColor(.veryLightPink, for: .normal)
        
        clientLabel.font = .textStyle7
        clientLabel.textColor = .white
        
        conditionLabel.font = .textStyle11
        conditionLabel.textColor = .white
        
        ourCardLabel.font = .textStyle11
        ourCardLabel.textColor = .white
        
        view.backgroundColor = UIColor.backgroundBlack
    }
    
    private func setupInputMask() {
        maskedDelegate = MaskedTextFieldDelegate(primaryFormat: "[0000] [0000] [0000] [0000]")
        cardNumberTextField.delegate = maskedDelegate
        maskedDelegate.listener = self
    }
    
    private func validateForm() {
        signInButton.isEnabled = false
        cardNumberTextField.text = "3428 4297 6661 937"
        cardNumberSubject.asObservable().bind { [weak self] (cardNumber) in
            if cardNumber.count == 16 {
                self?.signInButton.isEnabled = true
                self?.signInButton.layer.borderColor = UIColor.black.cgColor
                self?.signInButton.setTitleColor(.black, for: .normal)
            } else {
                self?.signInButton.isEnabled = false
                self?.signInButton.layer.borderColor = UIColor.veryLightPink.cgColor
                self?.signInButton.setTitleColor(.veryLightPink, for: .normal)
            }
        }.disposed(by: disposeBag)
    }
    
    @IBAction func signin(_ sender: UIButton) {
//        TokenService.accessToken = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhY2Nlc3MiLCJqdGkiOiIxIiwiYXVkIjoiVVNFUiIsImV4cCI6MTU0MjU0MzQ5MH0.VuxrJt0dbkOq72BPnR-tfILA_-m0NY2swriNrEoB78D5lqghNfsGLnz4amSGWzem1MRk837NJKwJ0YADNZr9zA"
//        self.openChat()
//        return
        guard
            let cardNumber = cardNumberTextField.text?.replacingOccurrences(of: " ", with: ""),
            !cardNumber.isEmpty
            else { return }
        
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
        ServiceLayer.shared.userService.authUser(cardNumber: cardNumber) { [weak self] result in
            switch result {
            case .success(let otp):
                self?.showPush(otp: otp.otp, cardNumber: cardNumber)
            case .error:
                print("login error")
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
    }
    
    private func openChat() {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window
            else { return }
        
        let navController = setupNavigationViewController()
        let controller = createChatViewController()
        
        navController.viewControllers.append(controller)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
    
    private func setupNavigationViewController() -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.isTranslucent = false
        return navController
    }
    
    private func createChatViewController() -> UIViewController {
        let model = ChatPresentationModel()
        let controller = ChatViewController(model: model)
        model.delegate = controller
        model.getHistory()
        return controller
    }
    

    func showPush(otp: Int, cardNumber: String) {
        let warning = MessageView.viewFromNib(layout: .cardView)
        warning.configureTheme(.warning)
        warning.configureDropShadow()
        
        let iconText = "😎"
        warning.configureContent(title: "Сообщение", body: "Ваш код для входа в приложение", iconText: iconText)
        warning.button?.isHidden = false
        warning.button?.setTitle("\(otp)", for: .normal)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(authByOtp))
        warning.button?.addGestureRecognizer(gesture)
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.duration = .forever
        warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        self.otp = otp
        self.cardNumber = cardNumber
        SwiftMessages.show(config: warningConfig, view: warning)
    }
    
    @objc func authByOtp() {
        ServiceLayer.shared.userService.authByOtp(otp: otp, cardNumber: cardNumber) { [weak self] (result) in
            switch result {
            case .success(let user):
                TokenService.accessToken = user.accessToken
                self?.openChat()
            case .error:
                print("ошибка")
            }
            SwiftMessages.hide()
        }
    }

}

extension LoginViewController: MaskedTextFieldDelegateListener {
    
    func textField(_ textField: UITextField, didFillMandatoryCharacters complete: Bool, didExtractValue value: String) {
        cardNumberSubject.onNext(value)
    }
    
}
