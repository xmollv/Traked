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

class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrayOfTvShows = [ShowOrMovie]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func viewDidAppear(animated: Bool) {
        self.collectionView.resetScrollPositionToTop()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arrayOfTvShows.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCellDiscover", forIndexPath: indexPath) as! BasicCellWatching
        
        cell.imageView.image = UIImage(named: "Grey background")
            
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
        performSegueWithIdentifier("ShowEpisodeListFromDiscover", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowEpisodeListFromDiscover" {
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