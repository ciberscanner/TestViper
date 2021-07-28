//
//  LoginProtocols.swift
//  SecureApp
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import Foundation
import UIKit
import SecureStaticLibrary


protocol LoginViewToPresenterProtocol: class {
    var view: LoginPresenterToViewProtocol? {get set}
    var interactor: LoginPresenterToInteractorProtocol? {get set}
    var router: LoginPresenterToRouterProtocol? {get set}
    
    func checkFields(mail: String, password: String)-> Bool
    func getDataAPI(user: User, lat: String, lon: String)
    func addLogin(user:User, response:ResponseAPI)
    func gotoHome()
}

protocol LoginPresenterToViewProtocol: class {
    func successData(response:ResponseAPI)
    func successLogin()
    func showAlert(title:String, msg:String)
}

protocol LoginPresenterToRouterProtocol: class {
    func showHome()
}

protocol LoginPresenterToInteractorProtocol {
    var presenter:LoginInteractorToPresenterProtocol? {get set}
    
    func getDataAPI(user: User, lat: String, lon: String)
    func addLogin(user:User, response:ResponseAPI)
    func isUser(user:User) -> Bool 
}

protocol LoginInteractorToPresenterProtocol: class {
    func loginSuccess()
    func loginFailed(message: DBMessage)
    func getDataSuccess(response: ResponseAPI)
    func getDataFailed(error: String)
    func showAlert(title:String, msg:String)
}

protocol LoginMainConfiguratorProtocol: class {
    func configure(with viewController: LoginViewController)
}
