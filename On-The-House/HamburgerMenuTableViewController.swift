//
//  HamburgerMenuTableViewController.swift
//  On-The-House
//
//  Created by Kay Hoang on 22/4/18.
//  Copyright © 2018 RMIT. All rights reserved.
//

import UIKit

class HamburgerMenuTableViewController: UITableViewController {

    @IBOutlet weak var lbUserName: UILabel!
    var WelcomeMsg = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWelcomeMsg()
    }
    func loadWelcomeMsg(){
        if let firstName = UserDefaults.standard.string(forKey: "first_name"), let lastName = UserDefaults.standard.string(forKey: "last_name")
        {
            WelcomeMsg = ("Welcome, \(String(describing: firstName)) \(String(describing: lastName))")
            lbUserName.text = WelcomeMsg
            print("this is welcome msg")
            print(WelcomeMsg)
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
}
