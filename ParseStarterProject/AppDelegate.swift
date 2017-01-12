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

// If you want to use any of the UI components, uncomment this line
// import ParseUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  //--------------------------------------
  // MARK: - UIApplicationDelegate
  //--------------------------------------
  // didFinishLaunchingWithOptions for Swift 3
  internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    PFUser.enableAutomaticUser()
    // config Parse Project
    let config  = ParseClientConfiguration { (ParseMutableClientConfiguration) in
      ParseMutableClientConfiguration.applicationId = "pushnotification123ghhgdf123"
      ParseMutableClientConfiguration.clientKey = "pushnotificationKeyfsdfsdf23(§ç!"
      ParseMutableClientConfiguration.server = "http://pushnotificationsofts.herokuapp.com/parse"
    }
    //initialize Parse with this Config
    Parse.initialize(with: config)
    // end
    let defaultACL = PFACL();
    
    // If you would like all objects to be private by default, remove this line.
    defaultACL.getPublicReadAccess = true
    defaultACL.getPublicWriteAccess = true
    PFACL.setDefault(defaultACL, withAccessForCurrentUser: true)
    
    if application.applicationState != UIApplicationState.background {
      
      
    }
    // call remember function to dismiss login view
    remember()
    return true
  }
  private func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
  }
  
  private func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
    
  }
  
  private func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
  }
  func remember(){
    let user : String? = UserDefaults.standard.string(forKey:"userinfo")
    if user != nil {
      let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
      let tabBar = board.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
      window?.rootViewController = tabBar
      
    }
  }
}
