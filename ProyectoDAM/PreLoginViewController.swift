//
//  PreLoginViewController.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 21/01/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import UIKit
import SafariServices

class PreLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func openWebLogin(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://api-v2launch.trakt.tv/oauth/authorize?response_type=code&client_id=bd184c0b9d554dd55a34e8b73e0a294524a8b66d4ae56da7261558c846645bf5&redirect_uri=ProyectoDAM://x.com")!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
