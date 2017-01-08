/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let object = PFObject(className: "user")
        object["name"] = "sassi"
        object["lastname"] = "yahya"
        // sava data in Heroku Server
        object.saveInBackground { (sucess,error) in
            if (error != nil) {
                print(error?.localizedDescription)
            }else{
                print("saved")
            }
        }
    }

}
