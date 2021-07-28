//
//  LoginPresenter.swift
//  SecureApp
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import Foundation
import UIKit
import SecureStaticLibrary

class LoginPresenter: LoginViewToPresenterProtocol {
    //--------------------------------------------------------------------
    //Variables
    weak var view: LoginPresenterToViewProtocol?
    var interactor: LoginPresenterToInteractorProtocol?
    var router: LoginPresenterToRouterProtocol?
    //--------------------------------------------------------------------
    //
    required init(view:LoginPresenterToViewProtocol){
        self.view = view
    }
    //--------------------------------------------------------------------
    //
    init(){
    }
    //--------------------------------------------------------------------
    //
    func gotoHome() {
        router?.showHome()
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
        if !(interactor?.isUser(user: User(username: mail, password: password)))!{
            showAlert(title: "Credentials", msg: "The username and password do not match a registered account")
            return false
        }
        return true
    }
    //--------------------------------------------------------------------
    //
    func getDataAPI(user: User, lat: String, lon: String){
        interactor?.getDataAPI(user: user, lat: lat, lon: lon)
    }
    //--------------------------------------------------------------------
    //
    func addLogin(user:User, response:ResponseAPI) {
        interactor?.addLogin(user: user, response: response)
    }
}

extension LoginPresenter: LoginInteractorToPresenterProtocol{
    func showAlert(title: String, msg: String) {
        view?.showAlert(title: "Error", msg: msg)
    }
    
    func loginSuccess() {
        view?.successLogin()
    }
    
    func loginFailed(message: DBMessage) {
        view?.showAlert(title: "Error", msg: message.message!)
    }
    
    func getDataSuccess(response: ResponseAPI) {
        view?.successData(response: response)
    }
    
    func getDataFailed(error: String) {
        view?.showAlert(title: "Error", msg: error)
    }
}
