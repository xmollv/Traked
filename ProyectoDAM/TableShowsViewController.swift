//
//  TableShowsViewController.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 25/01/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import UIKit
import Alamofire

class TableShowsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var showId = 0
    var showTitle = ""
    
    var arrayOfSeasons = [Seasons]()
    var arrayOfEpisodes = [Episodes]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let hudView = HudView.hudInView(view,animated: true)
        print("\(showTitle), \(showId)")
        
        title = showTitle
        
        Alamofire.request(.GET, "https://api-v2launch.trakt.tv/shows/\(showId)/seasons?extended=episodes", headers: Helper().getApiHeaders()).responseJSON{ response in
            switch response.result {
            case .Success (let JSON):
                if let seasons = JSON as? [[String:AnyObject]] {
                    for season in seasons {
                        
                        //Jumps the special episodes that are usually stored in the "0" season
                        if season["episodes"]![0]!["season"] as! Int == 0 {
                            continue
                        }
                        
                        self.arrayOfSeasons.append(Seasons(dictionary: season)!)
                    }
                    
                    for season in self.arrayOfSeasons{
                        for episode in season.episodes!{
                            self.arrayOfEpisodes.append(episode)
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                        hudView.removeFromSuperview()
                    })
                }
            case .Failure (let error):
                self.showSimpleAlert("¡Error!", message: "Ha habido un problema al realizar la petición al servidor. Vuelve a intentarlo en unos minutos.", buttonText: "Volver a intentarlo.")
                print("Request failed with error: \(error)")
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrayOfEpisodes.count == 0 {
            return 1
        } else {
            return arrayOfEpisodes.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! TableViewCell
        if arrayOfEpisodes.count != 0 {
            if let episodeName = arrayOfEpisodes[indexPath.row].title {
                cell.label.text = episodeName
            } else {
                cell.label.text = "TBA"
            }
        } else {
            cell.label.text = ""
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowEpisodeDetails" {
            let vc = segue.destinationViewController as! MovieEpisodeDetailsViewController
            let indexPath = tableView.indexPathForSelectedRow
            vc.elementId = arrayOfEpisodes[indexPath!.row].number!
            vc.elementTitle = arrayOfEpisodes[indexPath!.row].title!
        }
    }
    
    func showSimpleAlert(title: String, message: String, buttonText: String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
