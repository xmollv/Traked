//
//  HudView.swift
//  Snackson
//
//  Created by Desarrollo on 14/1/16.
//  Copyright © 2016 Adaptative Learning. All rights reserved.
//

import UIKit
class HudView: UIView {
    var text = ""
    
    class func hudInView(view: UIView, animated: Bool) -> HudView {
        let hudView = HudView(frame: view.bounds)
        hudView.opaque = false
        view.addSubview(hudView)
        view.userInteractionEnabled = true
        hudView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        hudView.addSubview(spinner)
        spinner.startAnimating()
        spinner.center=view.center;
    
        return hudView
    }
}
