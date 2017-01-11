//
//  feedCell.swift
//  ParseStarterProject-Swift
//
//  Created by Walid Sassi on 08/01/2017.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class feedCell: UITableViewCell {
    // variables and outlets
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var nameOwnerlabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var uiidlabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  @IBAction func likeBtnClicked(_ sender: Any) {
    let likeObject = PFObject(className: "likes")
    likeObject["from"] = PFUser.current()?.username
    likeObject["to"] = uiidlabel.text
    likeObject.saveInBackground { (success, error) in
      if error != nil {
        print(error?.localizedDescription)
      }else {
        print("post liked successfully")
      }
    }
  }
    
  @IBAction func commentBtnClicked(_ sender: Any) {
    let commentObject = PFObject(className: "comments")
    commentObject["from"] = PFUser.current()?.username
    commentObject["to"] = uiidlabel.text
    commentObject.saveInBackground { (success, error) in
      if error != nil {
        print(error?.localizedDescription)
      }else {
        print("post comment add successfully")
      }
    }

  }

}
