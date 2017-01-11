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
    // variables and outlets
    @IBOutlet weak var loginTxt: UITextField!
    @IBOutlet weak var passwdTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide keyboard
        let hidekeyborad = UITapGestureRecognizer(target: self, action: #selector(signInVC.hidekeyboradFn))
        hidekeyborad.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(hidekeyborad)
        
        // Do any additional setup after loading the view.
    }
    func hidekeyboradFn(){
        self.view.endEditing(true)
    }
    @IBAction func signInBtClick(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: loginTxt.text!, password: passwdTxt.text!){(success,error) in
            if error != nil {
              self.showalert(error: error! as NSError)
            }else {
                UserDefaults.standard.set(self.loginTxt.text!, forKey: "userinfo")
                UserDefaults.standard.synchronize()
                print("user successufuly logged in")
                self.performSegue(withIdentifier: "fromSignInToFeed", sender: nil)
            }
          
        }
    }
  // func to show alertview 
  func showalert(error:NSError){
    let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
    let button = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
    alert.addAction(button)
    self.present(alert, animated: true, completion: nil)

  }
    @IBAction func signUpBtClick(_ sender: Any) {
        let user = PFUser()
        user.username = loginTxt.text
        user.password = passwdTxt.text
        user["age"] = "32"
        user["gender"] = "male"
        user.signUpInBackground{ (success, error) in
            if error != nil {
              self.showalert(error: error! as NSError)
            }else{
                print("user successufuly created")
            }
        }
    }

   
}
