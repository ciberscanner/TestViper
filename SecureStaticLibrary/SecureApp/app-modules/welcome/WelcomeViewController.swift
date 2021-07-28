//
//  WelcomeViewController.swift
//  SecureApp
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import UIKit

class WelcomeViewController: UIViewController {
    //--------------------------------------------------------------------
    //Variables
    private var dataApp = DataApp()
    private var firstTime = false
    //--------------------------------------------------------------------
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTime = dataApp.firstTime()
    }
    //--------------------------------------------------------------------
    //
    override func viewDidAppear(_ animated: Bool) {
        if (firstTime){
            gotoView()
        }
    }
    //--------------------------------------------------------------------
    //
    func gotoView() {
        dataApp.saveFirstTime()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "loginViewController")
        show(secondVC, sender: self)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        gotoView()
    }
    
}
