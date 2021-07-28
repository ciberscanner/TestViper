//
//  RegisterViewController.swift
//  SecureApp
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import UIKit
import SecureStaticLibrary

class RegisterViewController: UIViewController, UITextFieldDelegate {
    //--------------------------------------------------------------------
    //Variables
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //let selfToRegisterSegueName = "SegueToRegister"
    var presenter: RegisterViewToPresenterProtocol?
    var configurator: RegisterConfigurator = RegisterConfigurator()
    //--------------------------------------------------------------------
    //Constructor
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        self.hideKeyboardWhenTappedAround()
        
        txtUsername.text = "df@s.com"
        txtPassword.text = "Abcd123@"
    }
    //--------------------------------------------------------------------
    //
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //--------------------------------------------------------------------
    //
    @IBAction func btnRegister(_ sender: Any) {
        if ((presenter?.checkFields(mail: txtUsername.text!, password: txtPassword.text!)) != nil){
            presenter?.addRegister(user: User(username: txtUsername.text!, password: txtPassword.text!) )
        }
    }
    //--------------------------------------------------------------------
    //
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}

extension RegisterViewController: RegisterPresenterToViewProtocol{
    func successRegister() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
