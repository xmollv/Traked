//
//  PreLoginViewController.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 21/01/16.
//  Copyright © 2016 Xavi. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        checkIfHasTokenAndIsValid()
    }
    @IBAction func openMainApp(sender: UIButton) {
        checkIfHasTokenAndIsValid()
    }
    
    @IBAction func openWebLogin(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://api-v2launch.trakt.tv/oauth/authorize?response_type=code&client_id=\(Helper().clientId)&redirect_uri=\(Helper().redirectUri)")!)
    }
    
    func checkIfHasTokenAndIsValid(){
        if Helper().getUserToken() != nil {
            let hudView = HudView.hudInView(view,animated: true)
            Alamofire.request(.GET, "https://api-v2launch.trakt.tv/users/me", headers: Helper().getApiHeaders()).responseJSON{ response in
                switch response.result {
                case .Success:
                    hudView.removeFromSuperview()
                    let vc = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarController")
                    self.presentViewController(vc, animated: true, completion: nil)
                    
                case .Failure (let error):
                    self.showSimpleAlert("¡Error!", message: "Ha habido un problema al realizar la petición al servidor. Vuelve a intentarlo en unos minutos.", buttonText: "Volver a intentarlo.")
                    print("Request failed with error: \(error)")
                }
            }
            
        }
    }
    
    func showSimpleAlert(title: String, message: String, buttonText: String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }


}
