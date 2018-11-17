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

final class LoginViewController: UIViewController {
    
    @IBOutlet weak private var cardNumberTextField: UITextField!
    @IBOutlet weak private var signInButton: UIButton!
    
    var model: LoginPresentationModel
    
    private var maskedDelegate: MaskedTextFieldDelegate!
    private var disposeBag = DisposeBag()
    private var cardNumberSubject = PublishSubject<String>()

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
    }
    
    private func setupUI() {
        
    }
    
    private func setupInputMask() {
        maskedDelegate = MaskedTextFieldDelegate(primaryFormat: "[0000]-[0000]-[0000]-[0000]")
        cardNumberTextField.delegate = maskedDelegate
        maskedDelegate.listener = self
    }
    
    private func validateForm() {
        signInButton.isEnabled = false
        
        cardNumberSubject.asObservable().bind { [weak self] (cardNumber) in
            self?.signInButton.isEnabled = cardNumber.count == 16
        }.disposed(by: disposeBag)
    }

}

extension LoginViewController: MaskedTextFieldDelegateListener {
    
    func textField(_ textField: UITextField, didFillMandatoryCharacters complete: Bool, didExtractValue value: String) {
        cardNumberSubject.onNext(value)
    }
    
}
