//
//  LoginInteractor.swift
//  SecureApp
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import Foundation
import SecureStaticLibrary

class LoginInteractor: LoginPresenterToInteractorProtocol {
    //--------------------------------------------------------------------
    //Variables
    var presenter: LoginInteractorToPresenterProtocol?
    private let dblogin = DBLogin()
    private let dbUser = DBUser()
    //--------------------------------------------------------------------
    //
    required init(presenter: LoginInteractorToPresenterProtocol){
        self.presenter = presenter
    }
    //--------------------------------------------------------------------
    //
    func getDataAPI(user: User, lat: String, lon: String){
        let url = MyAPI.getUrlAPI(lat: lat, lon: lon)
        RESTHelper.getRequest(url: url) { [self] (response: ResponseAPI, error) in
            if error != nil {
                self.presenter?.getDataFailed(error: error!.localizedDescription)
            }else{
                self.presenter?.getDataSuccess(response: response)
            }
        }
    }
    //--------------------------------------------------------------------
    //
    func addLogin(user:User, response:ResponseAPI){
        let message = dblogin.insertLogin(user: LoginAttempt(id: 0, username: user.username, date: response.time, access: "True", country: response.countryName))
        if message.code == Success{
            self.presenter?.loginSuccess()
        }else{
            self.presenter?.loginFailed(message: message)
        }
    }
    //--------------------------------------------------------------------
    //
    func isUser(user:User) -> Bool {
        return dbUser.checkUser(user: user)
    }
}
