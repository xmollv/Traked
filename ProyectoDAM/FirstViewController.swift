//
//  FirstViewController.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 21/12/15.
//  Copyright © 2015 TaniaXavi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var arrayOfTvShows = [TVShows]()
    //let arrayOfMovies = [Movies]()
    
    override func viewWillAppear(animated: Bool) {

        Alamofire.request(.GET, "https://api-v2launch.trakt.tv/users/\(Helper().getUserName())/watchlist/shows?extended=images", headers: Helper().getApiHeaders()).responseJSON{ response in
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Helper().clientId)
        print(Helper().getUserToken())
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        
        let hudView = HudView.hudInView(view,animated: true)
        
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.collectionView.reloadData()
            hudView.removeFromSuperview()
        }
    }
    
    @IBAction func segmentedControlAction(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! BasicCell
        
        cell.imageView.image = UIImage(named: "first")
        
        if segmentedControl.selectedSegmentIndex == 0 {
            cell.imageView.af_setImageWithURL(NSURL(string: arrayOfTvShows[indexPath.row].show!.images!.poster!.thumb!)!)
            //cell.imageView.af_setImageWithURL(NSURL(string: "https://walter.trakt.us/images/shows/000/060/300/posters/thumb/79bd96a4d3.jpg")!)
        } else {
            //cell.imageView.af_setImageWithURL(NSURL(named: arrayOfMovies.image!)!)
        }
        
        return cell
    }
    
    /*func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vistaDetalle: DetailBadgeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailBadgeViewController") as! DetailBadgeViewController
        //vistaDetalle.imagen = arrayOfBadgesGlobal[indexPath.row].imageStored!
        vistaDetalle.imagenString = arrayOfBadgesGlobal[indexPath.row].image!
        vistaDetalle.titleBadge = arrayOfBadgesGlobal[indexPath.row].name!;
        vistaDetalle.descriptionBadge = arrayOfBadgesGlobal[indexPath.row].description!;
        if let winDateRAW = arrayOfBadgesGlobal[indexPath.row].winDate {
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
            let winDate = dateFormatter.dateFromString(winDateRAW)
            
            
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            
            let myComponents = myCalendar.components(NSCalendarUnit.Day, fromDate: winDate!)
            let day = myComponents.day
            let myComponents2 = myCalendar.components(NSCalendarUnit.Month, fromDate: winDate!)
            let month = myComponents2.month
            let myComponents3 = myCalendar.components(NSCalendarUnit.Year, fromDate: winDate!)
            let year = myComponents3.year
            
            vistaDetalle.date = "Desbloqueaste esta insignia el \(day)-\(month)-\(year)"
        } else {
            vistaDetalle.date = ""
        }
        self.presentViewController(vistaDetalle, animated: true, completion: nil)
    }*/
    
    func showSimpleAlert(title: String, message: String, buttonText: String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
}