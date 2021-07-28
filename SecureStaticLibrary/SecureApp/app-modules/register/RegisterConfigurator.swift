//
//  RegisterConfigurator.swift
//  SecureApp
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import Foundation

class RegisterConfigurator: RegisterMainConfiguratorProtocol {
    
    func configure(with viewController: RegisterViewController) {
        let presenter = RegisterPresenter(view: viewController)
        let interactor = RegisterInteractor(presenter: presenter)
        let router = RegisterRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
