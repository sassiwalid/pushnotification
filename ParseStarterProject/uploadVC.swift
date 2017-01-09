//
//  uploadVC.swift
//  ParseStarterProject-Swift
//
//  Created by Walid Sassi on 08/01/2017.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse
class uploadVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate{

    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var textField: UITextView!
    
    @IBOutlet weak var uploadBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide keyboard
        let hidekeyborad = UITapGestureRecognizer(target: self, action: #selector(uploadVC.hidekeyboradFn))
        hidekeyborad.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(hidekeyborad)
        
        // configure the TapgestureRecognizer
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(uploadVC.selectImage))
        imageTap.numberOfTapsRequired = 1
        uploadImage.isUserInteractionEnabled = true
        uploadImage.addGestureRecognizer(imageTap)
        uploadBtn.isEnabled = false
    }
    func hidekeyboradFn(){
        self.view.endEditing(true)
    }
    // avoid confusion betewen the two TapgestureRecognizer
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func selectImage(){
        // pick the image from the photo library
        let picker = UIImagePickerController()
        picker.allowsEditing = true;
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    // update the imageview and dismiss the UIImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        uploadImage.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        uploadBtn.isEnabled = true
    }
    @IBAction func uploadBtnClicked(_ sender: Any) {
        // create Parse object
        let object = PFObject(className: "posts")
        // convert UIImage to Data
        let imageData = UIImageJPEGRepresentation(uploadImage.image!, 0.5)
        let pfImage = PFFile(name: "image.jpg", data: imageData!)
        object["image"] = pfImage
        // add post owner
        object["postowner"] = PFUser.current()?.username
        // add a unique identifier to the post
        let uuid = UUID().uuidString
        object["postuuid"] = uuid
        // add the post comment
        object["postcommenr"] = textField.text
        // save now
        object.saveInBackground { (sucess, error) in
            if error != nil {
                print(error?.localizedDescription)
            }else {
               print("post was uploaded successfuly !")
            }
        }
    }
}
