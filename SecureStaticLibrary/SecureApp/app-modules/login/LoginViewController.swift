//
//  LoginViewController.swift
//  SecureApp
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import UIKit
import SecureStaticLibrary
import CoreLocation

class LoginViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate  {
    //--------------------------------------------------------------------
    //Variables
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    let selfToRegisterSegueName = "SegueToRegister"
    var presenter: LoginViewToPresenterProtocol?
    var configurator: LoginConfigurator = LoginConfigurator()
    
    private var locationManager:CLLocationManager?
    private var isEnableLocation = false
    private var lat = ""
    private var lon = ""
    //--------------------------------------------------------------------
    //Constructor
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        self.hideKeyboardWhenTappedAround()
        isEnableLocation = getLatitudeLongitude()
        
        txtUsername.text = "df@s.com"
        txtPassword.text = "Abcd123@"
    }
    //--------------------------------------------------------------------
    //
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    //--------------------------------------------------------------------
    //
    func getLatitudeLongitude() ->Bool{
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        
        // Get the current location permissions
        let manager = CLLocationManager()

        // Handle each case of location permissions
        switch manager.authorizationStatus {
            case .authorizedAlways:
                print("Location authorizedAlways")
                return true
            case .authorizedWhenInUse:
                print("Location authorizedWhenInUse")
                return true
            case .denied:
                print("Location denied")
            case .notDetermined:
                print("Location notDetermined")
            case .restricted:
                print("Location restricted")
        @unknown default:
            print("Location default")
        }
        return false
    }
    //--------------------------------------------------------------------
    //
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            lat = "\(location.coordinate.latitude)"
            lon = "\(location.coordinate.longitude)"
            isEnableLocation = true
        }
    }
    //--------------------------------------------------------------------
    //
    @IBAction func btnLogin(_ sender: Any) {
        if ((presenter?.checkFields(mail: txtUsername.text!, password: txtPassword.text!)) != nil){
            isEnableLocation = getLatitudeLongitude()
            if  isEnableLocation{
                presenter?.getDataAPI(user: User(username: txtUsername.text!, password: txtPassword.text!), lat: lat, lon: lon)
            }else{
                showAlertLocation()
            }
        }
    }
    //--------------------------------------------------------------------
    //
    func showAlertLocation() {
        let alertController = UIAlertController(
            title: "Location Access Disabled",
            message: "Access to location is necessary, please open this app's settings and set location access to 'Always'.",
            preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let bundleId = Bundle.main.bundleIdentifier,
                let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)")
            {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)

        self.present(alertController, animated: true, completion: nil)
    }
}

extension LoginViewController: LoginPresenterToViewProtocol{
    //--------------------------------------------------------------------
    //
    func successData(response: ResponseAPI) {
        DispatchQueue.main.async {
            self.presenter?.addLogin(user: User(username: self.txtUsername.text!, password: self.txtPassword.text!), response: response)
        }
    }
    //--------------------------------------------------------------------
    //
    func successLogin() {
        presenter?.gotoHome()
    }
    //--------------------------------------------------------------------
    //
    func showAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
