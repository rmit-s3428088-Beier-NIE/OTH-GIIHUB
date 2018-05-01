//
//  FirstPageController.swift
//  On-The-House
//
//  Created by beier nie on 21/3/18.
//  Copyright © 2018 RMIT. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController : UIViewController {
    
    
    
    @IBOutlet weak var EmailInputBox: UITextField!
    
    
    @IBOutlet weak var PasswordInputBox: UITextField!
    
    var memberToken:Member?
    
    override func viewDidLoad() {
        
        
        EmailInputBox.placeholder="Email"
        PasswordInputBox.placeholder="Password"
        
        super.viewDidLoad()
        //printMyOffer()
        
    }
    @IBAction func btnLogin(_ sender: Any) {
        setMember()
    }
    func setMember() {
        if let usernameT = EmailInputBox.text, let passwordT = PasswordInputBox.text{
            let postBodys = "email=\(usernameT)&password=\(passwordT)"
            //let postBody = "email=nazisang@gmail.com&password=summer1993"
            //print(postBodys)
            let memberService = MemberService()
            
            memberService.login(postBody: postBodys) { (member) in
                self.memberToken = member
                
                UserDefaults.standard.set(self.memberToken?.id, forKey: "member_id")
                UserDefaults.standard.set(self.memberToken?.first_name, forKey: "first_name")
                UserDefaults.standard.set(self.memberToken?.last_name, forKey: "last_name")
                //UserDefaults.standard.set(Member.memberKeys.zone_id, forKey: "zone_id")
                //UserDefaults.standard.set(Member.memberKeys.timezone_id, forKey: "timezone_id")
                //UserDefaults.standard.set(Member.memberKeys.email, forKey: "email")
                //UserDefaults.standard.set(Member.memberKeys.nickname, forKey: "nickname")
                //UserDefaults.standard.set(Member.memberKeys.zip, forKey: "zip")
                //UserDefaults.standard.set(Member.memberKeys.membership_id, forKey: "membership_level_id")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.synchronize()
            }
        }
        
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginButton"{
            self.setMember()
            while memberToken?.status == nil {
            }
            if let status = memberToken?.status{
                if status == "success"{
                    let nextView: MyAccountViewController = segue.destination as! MyAccountViewController
                    if let nickname = self.memberToken?.nickname{
                        //print(nickname)
                        nextView.nickName = nickname
                        // String "email=nazisanh@gmail.com"
                    }
                }else if status == "error"{
                    //print("here")
                    let button2Alert: UIAlertView = UIAlertView(title: "error", message: "Your email or password is in correct",delegate: nil, cancelButtonTitle: "OK")
                    button2Alert.show()
                }
            }
        }
    }
    */
    
}

