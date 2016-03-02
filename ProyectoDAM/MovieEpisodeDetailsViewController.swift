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
    @IBOutlet weak var markAsSeenButton: UIButton!
    
    var movie: ShowOrMovie?
    var episode: Episodes?
    var movieWatched: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBarHidden = false
        
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
            
            if movieWatched == true {
                markAsSeenButton.hidden = true
            }
        }
        
    }
    @IBAction func markAsSeen(sender: UIButton) {
        refreshFirstVC = true
        refreshThirdVC = true
        if let _ = episode {
            refreshSecondVC = true
            
            let parameters = ["episodes": [["ids": ["trakt" : "\(episode!.ids!.trakt!)"] ]] ]
            
            Alamofire.request(.POST, "https://api-v2launch.trakt.tv/sync/history", headers: Helper().getApiHeaders(), parameters: parameters, encoding: .JSON).responseJSON{ response in
                switch response.result {
                case .Success (let JSON):
                    print("Episode marked as seen: \(JSON)")
                    
                case .Failure (let error):
                    self.showSimpleAlert("¡Error!", message: "Ha habido un problema al realizar la petición al servidor. Vuelve a intentarlo en unos minutos.", buttonText: "Volver a intentarlo.")
                    print("Request failed with error: \(error)")
                }
            }
            
        } else {
            
            let parameters = ["movies": [["ids": ["trakt" : "\(movie!.ids!.trakt!)"] ]] ]

            Alamofire.request(.POST, "https://api-v2launch.trakt.tv/sync/history", headers: Helper().getApiHeaders(), parameters: parameters, encoding: .JSON).responseJSON{ response in
                switch response.result {
                case .Success (let JSON):
                    print("Movie marked as seen: \(JSON)")
                    
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
