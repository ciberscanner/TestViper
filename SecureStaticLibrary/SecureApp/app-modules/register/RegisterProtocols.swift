//
//  RegisterProtocols.swift
//  SecureApp
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import Foundation
import UIKit
import SecureStaticLibrary


protocol RegisterViewToPresenterProtocol: class {
    var view: RegisterPresenterToViewProtocol? {get set}
    var interactor: RegisterPresenterToInteractorProtocol? {get set}
    var router: RegisterPresenterToRouterProtocol? {get set}
    
    func checkFields(mail: String, password: String)-> Bool
    func addRegister(user:User)
    func gotoHome()
}

protocol RegisterPresenterToViewProtocol: class {
    func successRegister()
    func showAlert(title:String, msg:String)
}

protocol RegisterPresenterToRouterProtocol: class {
    func showHome(on view: RegisterPresenterToViewProtocol)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

protocol RegisterPresenterToInteractorProtocol {
    var presenter:RegisterInteractorToPresenterProtocol? {get set}
    func addRegister(user:User)
    func isUser(user:User) -> Bool
}

protocol RegisterInteractorToPresenterProtocol: class {
    func registerSuccess()
    func registerFailed(message: DBMessage)
    func showAlert(title:String, msg:String)
}

protocol RegisterMainConfiguratorProtocol: class {
    func configure(with viewController: RegisterViewController)
}
