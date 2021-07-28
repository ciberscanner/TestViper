//
//  HomeViewController.swift
//  SecureApp
//
//  Created by Diego Fernando Serna Salazar on 28.07.21.
//

import UIKit
import SecureStaticLibrary

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    //--------------------------------------------------------------------
    //Variables
    @IBOutlet weak var tableView: UITableView!
    var logins:[LoginAttempt] = []
    private let dblogin = DBLogin()
    //--------------------------------------------------------------------
    //Constructor
    override func viewDidLoad() {
        super.viewDidLoad()
        logins = dblogin.readLogins()
    }
    //--------------------------------------------------------------------
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.logins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = logins[indexPath.row].username
        cell.detailTextLabel?.text = "\(logins[indexPath.row].date) \(logins[indexPath.row].country)"

        return cell
    }
}
