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
    var tvShow: ShowOrMovie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check if there are seasons. If there are, we shouldn't download again the same seasons. This should be checked
        tvShow!.seasons = [Seasons]()
        
        
        let hudView = HudView.hudInView(view,animated: true)
        print("\(tvShow!.title!), \(tvShow!.ids!.trakt!)")
        
        title = tvShow!.title!
        
        Alamofire.request(.GET, "https://api-v2launch.trakt.tv/shows/\(tvShow!.ids!.trakt!)/seasons?extended=episodes,full,images", headers: Helper().getApiHeaders()).responseJSON{ response in
            switch response.result {
            case .Success (let JSON):
                if let seasons = JSON as? [[String:AnyObject]] {
                    for season in seasons{
                        //This if skips the special seasons
                        if season["episodes"]![0]!["season"] as! Int == 0 {
                            continue
                        }
                        self.tvShow!.seasons!.append(Seasons(dictionary: season)!)
                    }
                    
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    let cal = NSCalendar.currentCalendar()
                    
                    for season in self.tvShow!.seasons!{
                        for episode in season.episodes! {
                            if let _ = episode.firstAired {
                                let date = dateFormatter.dateFromString(episode.firstAired!)!
                                
                                let year = cal.component(NSCalendarUnit.Year, fromDate: date)
                                let month = cal.component(NSCalendarUnit.Month, fromDate: date)
                                let day = cal.component(NSCalendarUnit.Day, fromDate: date)
                                
                                episode.firstAired = "\(day)/\(month)/\(year)"
                            }
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let _ = tvShow!.seasons {
            return tvShow!.seasons!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let seasons = tvShow!.seasons {
            if seasons.count == 0 {
                return 0
            } else {
                return seasons[section].episodes!.count
            }
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! TableViewCell
        if tvShow!.seasons!.count != 0 {
            
            if let episodeName = tvShow!.seasons![indexPath.section].episodes![indexPath.row].title {
                cell.label.text = episodeName
                cell.episodeNumberLabel.text = "\(indexPath.row)"
                
                if let dateAired = tvShow!.seasons![indexPath.section].episodes![indexPath.row].firstAired {
                    cell.dateLabel.text = dateAired
                } else {
                    cell.dateLabel.text = ""
                }
                
            } else {
                cell.label.text = "TBA"
                cell.dateLabel.text = ""
                cell.episodeNumberLabel.text = ""
            }

        } else {
            cell.label.text = ""
            cell.dateLabel.text = ""
            cell.episodeNumberLabel.text = ""
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Season \(tvShow!.seasons![section].number!)"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowEpisodeDetails" {
            let vc = segue.destinationViewController as! MovieEpisodeDetailsViewController
            let indexPath = tableView.indexPathForSelectedRow
            //vc.showOrMovie = tvShow!
            vc.episode = tvShow!.seasons![indexPath!.section].episodes![indexPath!.row]
        }
    }
    
    func showSimpleAlert(title: String, message: String, buttonText: String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
