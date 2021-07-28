//
//  RegisterInteractor.swift
//  SecureApp
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import SecureStaticLibrary

class RegisterInteractor: RegisterPresenterToInteractorProtocol {
    //--------------------------------------------------------------------
    //Variables
    var presenter: RegisterInteractorToPresenterProtocol?
    private let dbUser = DBUser()
    //--------------------------------------------------------------------
    //
    required init(presenter: RegisterInteractorToPresenterProtocol){
        self.presenter = presenter
    }
    //--------------------------------------------------------------------
    //
    func addRegister(user:User){
        let message = dbUser.addUser(user: user)
        if message.code == Success{
            self.presenter?.registerSuccess()
        }else{
            self.presenter?.registerFailed(message: message)
        }
    }
    //--------------------------------------------------------------------
    //
    func isUser(user:User) -> Bool {
        return dbUser.checkUser(user: user)
    }
}
