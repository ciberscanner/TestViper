//
//  RegisterPresenter.swift
//  SecureApp
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import UIKit
import SecureStaticLibrary

class RegisterPresenter: RegisterViewToPresenterProtocol {
    //--------------------------------------------------------------------
    //Variables
    weak var view: RegisterPresenterToViewProtocol?
    var interactor: RegisterPresenterToInteractorProtocol?
    var router: RegisterPresenterToRouterProtocol?
    //--------------------------------------------------------------------
    //
    required init(view:RegisterPresenterToViewProtocol){
        self.view = view
    }
    //--------------------------------------------------------------------
    //
    init(){
    }
    //--------------------------------------------------------------------
    //
    func gotoHome() {
        router?.showHome(on: view!)
    }
    //--------------------------------------------------------------------
    //
    func checkFields(mail: String, password: String)-> Bool {
        if !mail.isValidEmail{
            showAlert(title: "Username", msg: "The email is not valid")
            return false
        }
        if !password.isValidPassword{
            showAlert(title: "Password", msg: "The password is not valid")
            return false
        }
        if (interactor?.isUser(user: User(username: mail, password: password)))!{
            showAlert(title: "User", msg: "This user is already registered!")
            return false
        }
        return true
    }
    //--------------------------------------------------------------------
    //
    func addRegister(user: User) {
        interactor?.addRegister(user: user)
    }
}

extension RegisterPresenter: RegisterInteractorToPresenterProtocol{
    func showAlert(title: String, msg: String) {
        view?.showAlert(title: "Error", msg: msg)
    }
    
    func registerSuccess() {
        view?.successRegister()
    }
    
    func registerFailed(message: DBMessage) {
        view?.showAlert(title: "Error", msg: message.message!)
    }
}
