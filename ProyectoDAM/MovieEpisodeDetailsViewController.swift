//
//  MovieDetailsViewController.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 26/01/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import UIKit

class MovieEpisodeDetailsViewController: UIViewController {
    
    var movie: ShowOrMovie?
    var episode: Episodes?
    
    /*var elementId: Int? //This can be a movieId or an episodeId
    var elementTitle: String?
    var tvshowId: Int? //This will only have a value if the segue came from an episode list
    var seasonId: Int? //This will only have a value if the segue came from an episode list*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = movie {
            title = movie!.title!
        } else if let _ = episode {
            title = episode!.title!
        }
        
        //print("\(elementTitle!), \(elementId!), \(tvshowId), \(seasonId)")
    }
    
    func showSimpleAlert(title: String, message: String, buttonText: String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}
