//
//  MovieDetailsViewController.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 26/01/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import UIKit
import Alamofire

class MovieEpisodeDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageHeader: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: ShowOrMovie?
    var episode: Episodes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = episode {
            
            print("\(episode!.season!), \(episode!.number!)")
            
            if let episodeTitle = episode!.title {
                title = episodeTitle
            } else {
                title = "TBA"
            }

            if let screenshot = episode!.images!.screenshot!.thumb {
                imageHeader.af_setImageWithURL(NSURL(string: screenshot)!)
            } else {
                imageHeader.image = UIImage(named: "No Image")
            }
            
            if let overview = episode!.overview {
                descriptionLabel.text = overview
            } else {
                descriptionLabel.text = "No description yet!"
            }
            
        } else {
            title = movie!.title!
            
            if let poster = movie!.images!.poster!.thumb {
                imageHeader.af_setImageWithURL(NSURL(string: poster)!)
            } else {
                imageHeader.image = UIImage(named: "No Image")
            }
            
            if let overview = movie!.overview {
                descriptionLabel.text = overview
            } else {
                descriptionLabel.text = "No overview yet"
            }
        }
        
    }
    
    func showSimpleAlert(title: String, message: String, buttonText: String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}
