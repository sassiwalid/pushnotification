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
    var userarray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // insert some data in heroku server
        let object = PFObject(className: "user")
        object["name"] = "sassi"
        object["lastname"] = "Imen"
        // sava data in Heroku Server
        object.saveInBackground { (sucess,error) in
            if (error != nil) {
                print(error?.localizedDescription)
            }else{
                print("saved")
            }
        }
        // retrieve data from heroku server
        let query = PFQuery(className: "user")
        query.findObjectsInBackground { (objects, error) in
            if (error != nil) {
                print (error?.localizedDescription)
            }
            else{
                for data in objects! {
                self.userarray.append(data.object(forKey: "lastname") as! String)
                }
            print(self.userarray)
            }
        }
    }

}
