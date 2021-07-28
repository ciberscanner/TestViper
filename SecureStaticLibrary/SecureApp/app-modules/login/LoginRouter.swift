//
//  LoginRouter.swift
//  SecureApp
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import Foundation
import UIKit

class LoginRouter: LoginPresenterToRouterProtocol {
    //--------------------------------------------------------------------
    //Variables
    weak var viewController:LoginViewController?
    //--------------------------------------------------------------------
    //
    init(viewController:LoginViewController){
        self.viewController = viewController
    }
    //--------------------------------------------------------------------
    //
    func showHome() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: "homeViewController")
            self.viewController!.show(secondVC, sender: self)
        }
        
    }
}
