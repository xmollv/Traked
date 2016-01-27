//
//  PreLoginViewController.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 21/01/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        if Helper().getUserToken() != nil {
            performSegueWithIdentifier("ShowMainView", sender: nil)
        }
    }
    @IBAction func openMainApp(sender: UIButton) {
        if Helper().getUserToken() != nil {
            performSegueWithIdentifier("ShowMainView", sender: nil)
        }
    }
    
    @IBAction func openWebLogin(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://api-v2launch.trakt.tv/oauth/authorize?response_type=code&client_id=\(Helper().clientId)&redirect_uri=\(Helper().redirectUri)")!)
    }


}
