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
    // Enable storing and querying data from Local Datastore.
    // Remove this line if you don't want to use Local Datastore features or want to use cachePolicy.
    Parse.enableLocalDatastore()
    
    // ****************************************************************************
    // Uncomment and fill in with your Parse credentials:
    // Parse.setApplicationId("your_application_id", clientKey: "your_client_key")
    //
    // If you are using Facebook, uncomment and add your FacebookAppID to your bundle's plist as
    // described here: https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/
    // Uncomment the line inside ParseStartProject-Bridging-Header and the following line here:
    // PFFacebookUtils.initializeFacebook()
    // ****************************************************************************
    
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
      // Track an app open here if we launch with a push, unless
      // "content_available" was used to trigger a background push (introduced in iOS 7).
      // In that case, we skip tracking here to avoid double counting the app-open.
      
      let preBackgroundPush = !application.responds(to: #selector(getter: UIApplication.backgroundRefreshStatus))
      let oldPushHandlerOnly = !self.responds(to: #selector(UIApplicationDelegate.application(_:didReceiveRemoteNotification:fetchCompletionHandler:)))
      let noPushPayload = false;
      launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] != nil
      if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
        PFAnalytics.trackAppOpened(launchOptions: launchOptions)
      }
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
    PFPush.handle(userInfo)
    if application.applicationState == UIApplicationState.inactive {
      PFAnalytics.trackAppOpened(withRemoteNotificationPayload: userInfo)
    }
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
