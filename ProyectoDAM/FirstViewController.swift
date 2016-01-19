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
    
    //let arrayOfTvShows = [TVShows]()
    //let arrayOfMovies = [Movies]()
    
    override func viewWillAppear(animated: Bool) {
        
        let headers = ["Content-Type":"application/json", "trakt-api-version":"2", "trakt-api-key":TraktKeys().clientId]
        
        Alamofire.request(.GET, "https://api-v2launch.trakt.tv/users/ProjecteDAM/watchlist/movies", headers: headers).responseJSON{ response in
            switch response.result {
            case .Success (let JSON):
                print(JSON)
                //if let favorites = JSON["result"] as? [[String:AnyObject]] {
                        //print(JSON)
                        /*for favorite in favorites {
                            arrayOfFavoritesGlobal.append(ResultFavorites(dictionary: favorite)!)
                        }
                        
                        for elem in arrayOfFavoritesGlobal {
                            if let _ = elem.favoriteDate {
                                let dateFormatter = NSDateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
                                let dateFormatted = dateFormatter.dateFromString(elem.favoriteDate!)
                                let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
                                let myComponents = myCalendar.components([.Day, .Month, .Year], fromDate: dateFormatted!)
                                elem.favoriteDateFormatted = "\(myComponents.day)-\(myComponents.month)-\(myComponents.year)"
                            }
                        }*/
                //}
            case .Failure (let error):
                self.showSimpleAlert("¡Error!", message: "Ha habido un problema al realizar la petición al servidor. Vuelve a intentarlo en unos minutos.", buttonText: "Volver a intentarlo.")
                print("Request failed with error: \(error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
    }
    
    @IBAction func segmentedControlAction(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            collectionView.reloadData()
            print("Shows")
        } else if sender.selectedSegmentIndex == 1 {
            collectionView.reloadData()
            print("Movies")
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
        /*if segmentedControl.selectedSegmentIndex == 0 {
            return arrayOfTvShows.count
        } else {
            return arrayOfMovies.count
        }*/
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! BasicCell
        
        cell.imageView.image = UIImage(named: "first")
        
        /*if segmentedControl.selectedSegmentIndex == 0 {
            cell.imageView.af_setImageWithURL(NSURL(named: arrayOfTvShows.image!)!)
        } else {
            cell.imageView.af_setImageWithURL(NSURL(named: arrayOfMovies.image!)!)
        }*/
        
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