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
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var arrayOfTvShows = [TVShows]()
    //let arrayOfMovies = [Movies]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hudView = HudView.hudInView(view,animated: true)
        
        Alamofire.request(.GET, "https://api-v2launch.trakt.tv/shows/popular?extended=images", headers: Helper().getApiHeaders()).responseJSON{ response in
            switch response.result {
            case .Success (let JSON):
                if let shows = JSON as? [[String:AnyObject]] {
                    for show in shows{
                        self.arrayOfTvShows.append(TVShows(dictionary: show)!)
                    }
                }
            case .Failure (let error):
                self.showSimpleAlert("¡Error!", message: "Ha habido un problema al realizar la petición al servidor. Vuelve a intentarlo en unos minutos.", buttonText: "Volver a intentarlo.")
                print("Request failed with error: \(error)")
            }
        }
        
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.collectionView.reloadData()
            hudView.removeFromSuperview()
        }
    }
    
    
    @IBAction func segmentedControlAction(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            collectionView.reloadData()
        } else if sender.selectedSegmentIndex == 1 {
            collectionView.reloadData()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return arrayOfTvShows.count
        } else {
            //return arrayOfMovies.count
            return 1
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCellDiscover", forIndexPath: indexPath) as! BasicCellDiscover
        
        cell.imageView.image = nil
        
        /*if segmentedControl.selectedSegmentIndex == 0 {
            cell.imageView.af_setImageWithURL(NSURL(string: arrayOfTvShows[indexPath.row].show!.images!.poster!.thumb!)!)
        } else {
            //cell.imageView.af_setImageWithURL(NSURL(named: arrayOfMovies.image!)!)
        }*/
        
        return cell
    }
    
    func showSimpleAlert(title: String, message: String, buttonText: String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}