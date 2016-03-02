//
//  SecondViewController.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 21/12/15.
//  Copyright © 2015 TaniaXavi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

var refreshSecondVC = false

class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrayOfTvShows = [ShowOrMovie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadContentsForTheSecondVC()
    }
    
    override func viewDidAppear(animated: Bool) {
        if refreshSecondVC {
            downloadContentsForTheSecondVC()
            refreshSecondVC = false
        }
        self.collectionView.resetScrollPositionToTop()
    }
    
    func downloadContentsForTheSecondVC() {
        arrayOfTvShows = [ShowOrMovie]()
        let hudView = HudView.hudInView(view,animated: true)
        
        Alamofire.request(.GET, "https://api-v2launch.trakt.tv/sync/watched/shows?extended=full,images", headers: Helper().getApiHeaders()).responseJSON{ response in
            switch response.result {
            case .Success (let JSON):
                if let dictionaryJSON = JSON as? [[String:AnyObject]] {
                    for showInDictionary in dictionaryJSON {
                        if let show = showInDictionary["show"] as? [String:AnyObject]{
                            self.arrayOfTvShows.append(ShowOrMovie(dictionary: show)!)
                        }
                    }
                }
                
                self.collectionView.reloadData()
                hudView.removeFromSuperview()
                
            case .Failure (let error):
                self.showSimpleAlert("¡Error!", message: "Ha habido un problema al realizar la petición al servidor. Vuelve a intentarlo en unos minutos.", buttonText: "Volver a intentarlo.")
                print("Request failed with error: \(error)")
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arrayOfTvShows.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCellWatching", forIndexPath: indexPath) as! BasicCellWatching
        cell.containerRemainingDaysView.layer.cornerRadius = 5
        cell.imageView.image = UIImage(named: "Grey background")
        cell.remainingDaysLabel.text = "0"
            
        if let thumb = arrayOfTvShows[indexPath.row].images!.poster!.thumb {
            cell.imageView.af_setImageWithURL(NSURL(string: thumb)!)
        } else if let medium = arrayOfTvShows[indexPath.row].images!.poster!.medium {
            cell.imageView.af_setImageWithURL(NSURL(string: medium)!)
        } else if let full = arrayOfTvShows[indexPath.row].images!.poster!.full {
            cell.imageView.af_setImageWithURL(NSURL(string: full)!)
        } else {
            cell.imageView.image = UIImage(named: "No image")
        }

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ShowEpisodeListFromWatching", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowEpisodeListFromWatching" {
            let vc = segue.destinationViewController as! TableShowsViewController
            let indexPath = collectionView.indexPathsForSelectedItems()
            vc.tvShow = arrayOfTvShows[indexPath![0].row]
        }
        
    }
    
    func showSimpleAlert(title: String, message: String, buttonText: String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}