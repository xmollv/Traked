//
//  AppDelegate.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 21/12/15.
//  Copyright © 2015 Xavi. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        var brokenString = url.query!.componentsSeparatedByString("=")
        if brokenString[0] != "error" {
            
            let helper = Helper()
            
            let headers = ["Content-Type" : "application/json"]
            let parameters = ["code": "\(brokenString[1])", "client_id": "\(helper.clientId)", "client_secret": "\(helper.clientSecret)", "redirect_uri": "\(helper.redirectUri)", "grant_type": "authorization_code"]
            
            Alamofire.request(.POST, "https://api-v2launch.trakt.tv/oauth/token", headers: headers, parameters: parameters, encoding: .JSON).responseJSON{ response in
                switch response.result {
                case .Success (let JSON):
                    print("New token -> \(JSON["access_token"]!!)")
                    NSUserDefaults.standardUserDefaults().setObject("\(JSON["access_token"]!!)", forKey: "access_token")
                    
                case .Failure (let error):
                    //self.showSimpleAlert("¡Error!", message: "Ha habido un problema al realizar la petición al servidor. Vuelve a intentarlo en unos minutos.", buttonText: "Volver a intentarlo.")
                    print("Request failed with error: \(error)")
                }
            }
            
        } else {
            //SHOW ERROR MESSAGE ON THE SCREEN
        }
        return true
    }

}

extension UIScrollView {
    /// Sets content offset to the top.
    func resetScrollPositionToTop() {
        self.contentOffset = CGPoint(x: -contentInset.left, y: -contentInset.top)
    }
}

