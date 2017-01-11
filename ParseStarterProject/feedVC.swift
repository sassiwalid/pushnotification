//
//  feedVC.swift
//  ParseStarterProject-Swift
//
//  Created by Walid Sassi on 08/01/2017.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class feedVC: UIViewController ,UITableViewDelegate,UITableViewDataSource{
  // variables and outlets
  @IBOutlet weak var tableView: UITableView!
  var postOwnerArray = [String]()
  var postcommentArray = [String]()
  var postImageArray = [PFFile]()
  var postUUIDArray = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    getDataFromParse()
     }
  override func viewWillAppear(_ animated: Bool) {
    // receive local notification from upladVC to reload data
    NotificationCenter.default.addObserver(self, selector: #selector(feedVC.updateData(_:)), name: NSNotification.Name(rawValue:"pictureAdded"), object: nil)
    
  }
  func updateData( _ notification:Notification){
    // call getDataFromParse() every notification observed
    getDataFromParse()
    // refresh tableview data
    self.tableView.reloadData()
  }
  // function that retrieve data from posts table 
  func getDataFromParse(){
    let query = PFQuery(className: "posts")
    query.addDescendingOrder("_created_at")
    query.findObjectsInBackground { (objects, error) in
      if error != nil {
        self.showalert(error: error! as NSError)

      }else{
        // clear every array of contents
        self.postImageArray.removeAll(keepingCapacity: false)
        self.postOwnerArray.removeAll(keepingCapacity: false)
        self.postcommentArray.removeAll(keepingCapacity: false)
        self.postUUIDArray.removeAll(keepingCapacity: false)
        // now add feeds to the arrays
        for object in objects! {
          self.postOwnerArray.append(object.value(forKey: "postowner")as! String)
          self.postcommentArray.append(object.value(forKey: "postcomment") as! String)
          self.postImageArray.append(object.value(forKey: "image")as! PFFile)
          self.postUUIDArray.append(object.value(forKey: "postuuid") as! String)
        }
       self.tableView.reloadData()
        
      }
    }
    // func to show alertview
  

  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return postOwnerArray.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! feedCell
    cell.uiidlabel.isHidden = true
    cell.nameOwnerlabel.text = self.postOwnerArray[indexPath.row]
    cell.commentLabel.text = self.postcommentArray[indexPath.row]
    cell.uiidlabel.text = self.postUUIDArray[indexPath.row]
    self.postImageArray[indexPath.row].getDataInBackground { (data, error) in
      if error != nil {
        self.showalert(error: error! as NSError)

      }else{
        cell.feedImage.image = UIImage(data: data!)
      }
    }
    return cell
  }
  func showalert(error:NSError){
    let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
    let button = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
    alert.addAction(button)
    self.present(alert, animated: true, completion: nil)
    
  }
 
  @IBAction func logOutBtnClicked(_ sender: UIBarButtonItem) {
    PFUser.logOutInBackground { (error) in
      if error != nil {
         self.showalert(error: error! as NSError)
      }else{
        let signInController = self.storyboard?.instantiateViewController(withIdentifier: "signin") as! signInVC
       let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = signInController
      }
    }
  }
  
}
