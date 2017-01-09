//
//  signInVC.swift
//  ParseStarterProject-Swift
//
//  Created by Walid Sassi on 08/01/2017.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class signInVC: UIViewController {

    @IBOutlet weak var loginTxt: UITextField!
    @IBOutlet weak var passwdTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signInBtClick(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: loginTxt.text!, password: passwdTxt.text!){(success,error) in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                print("user successufuly logged in")
                self.performSegue(withIdentifier: "fromSignInToFeed", sender: nil)
            }
            
        }
    }
    @IBAction func signUpBtClick(_ sender: Any) {
        let user = PFUser()
        user.username = loginTxt.text
        user.password = passwdTxt.text
        user["age"] = "32"
        user["gender"] = "male"
        user.signUpInBackground{ (success, error) in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                print("user successufuly created")
            }
        }
    }

   
}
