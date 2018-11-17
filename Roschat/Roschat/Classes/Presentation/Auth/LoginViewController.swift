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
        guard
            let cardNumber = cardNumberTextField.text?.replacingOccurrences(of: " ", with: ""),
            !cardNumber.isEmpty
            else { return }
        
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
        ServiceLayer.shared.userService.authUser(cardNumber: cardNumber) { [weak self] result in
            switch result {
            case .success(let user):
                self?.openChat(user: user)
            case .error:
                print("login error")
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
        }
    }
    
    private func openChat(user: User) {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window
            else { return }
        
        let navController = setupNavigationViewController()
        let controller = createChatViewController()
        
        navController.viewControllers.append(controller)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        
        TokenService.accessToken = user.accessToken
    }
    
    private func setupNavigationViewController() -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.isTranslucent = false
        return navController
    }
    
    private func createChatViewController() -> UIViewController {
        let model = ChatPresentationModel()
        let controller = ChatViewController(model: model)
        return controller
    }

}

extension LoginViewController: MaskedTextFieldDelegateListener {
    
    func textField(_ textField: UITextField, didFillMandatoryCharacters complete: Bool, didExtractValue value: String) {
        cardNumberSubject.onNext(value)
    }
    
}
