//
//  RegisterRouter.swift
//  SecureApp
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import Foundation
import UIKit

class RegisterRouter: RegisterPresenterToRouterProtocol {
    //--------------------------------------------------------------------
    //Variables
    weak var viewController:RegisterViewController?
    //--------------------------------------------------------------------
    //
    init(viewController:RegisterViewController){
        self.viewController = viewController
    }
    //--------------------------------------------------------------------
    //
    func showHome(on view: RegisterPresenterToViewProtocol) {
        //viewController!.performSegue(withIdentifier: viewController!.selfToRegisterSegueName, sender: nil)
    }
    //--------------------------------------------------------------------
    //
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let homeController = segue.destination as? HomeViewController
        //lfViewController!.longform = lf
    }
}
