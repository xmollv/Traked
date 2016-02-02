//
//  MovieDetailsViewController.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 26/01/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import UIKit

class MovieEpisodeDetailsViewController: UIViewController {
    
    var elementId: Int?
    var elementTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = elementTitle!
        print("\(elementTitle!), \(elementId!)")
    }
    
    func showSimpleAlert(title: String, message: String, buttonText: String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}
