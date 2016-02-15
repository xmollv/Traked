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
    
    var arrayOfTvShows = [Result]()
    var arrayOfMovies = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hudView = HudView.hudInView(view,animated: true)
        
        if let _ = Helper().getUserToken() {
            print("Client ID -> \(Helper().clientId)")
            print("User Token -> \(Helper().getUserToken()!)")
            
            Alamofire.request(.GET, "https://api-v2launch.trakt.tv/users/me/watchlist/shows?extended=images", headers: Helper().getApiHeaders()).responseJSON{ response in
                switch response.result {
                case .Success (let JSON):
                    if let shows = JSON as? [[String:AnyObject]] {
                        for show in shows{
                            self.arrayOfTvShows.append(Result(dictionary: show)!)
                        }
                        self.collectionView.reloadData()
                        hudView.removeFromSuperview()
                    }
                case .Failure (let error):
                    self.showSimpleAlert("¡Error!", message: "Ha habido un problema al realizar la petición al servidor. Vuelve a intentarlo en unos minutos.", buttonText: "Volver a intentarlo.")
                    print("Request failed with error: \(error)")
                }
            }
            
            Alamofire.request(.GET, "https://api-v2launch.trakt.tv/users/me/watchlist/movies?extended=images", headers: Helper().getApiHeaders()).responseJSON{ response in
                switch response.result {
                case .Success (let JSON):
                    if let movies = JSON as? [[String:AnyObject]] {
                        for movie in movies{
                            self.arrayOfMovies.append(Result(dictionary: movie)!)
                        }
                        self.collectionView.reloadData()
                        hudView.removeFromSuperview()
                    }
                case .Failure (let error):
                    self.showSimpleAlert("¡Error!", message: "Ha habido un problema al realizar la petición al servidor. Vuelve a intentarlo en unos minutos.", buttonText: "Volver a intentarlo.")
                    print("Request failed with error: \(error)")
                }
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.collectionView.resetScrollPositionToTop()
    }
    
    @IBAction func segmentedControlAction(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            collectionView.reloadData()
            self.collectionView.resetScrollPositionToTop()
        } else if sender.selectedSegmentIndex == 1 {
            collectionView.reloadData()
            self.collectionView.resetScrollPositionToTop()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return arrayOfTvShows.count
        } else {
            return arrayOfMovies.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCellWatchlist", forIndexPath: indexPath) as! BasicCellWatchslist
        //cell.containerRemainingDays.layer.cornerRadius = 6
        
        cell.imageView.image = UIImage(named: "Grey background")
        
        if segmentedControl.selectedSegmentIndex == 0 {
            
            if let thumb = arrayOfTvShows[indexPath.row].showOrMovie!.images!.poster!.thumb {
                cell.imageView.af_setImageWithURL(NSURL(string: thumb)!)
            } else if let medium = arrayOfTvShows[indexPath.row].showOrMovie!.images!.poster!.medium {
                cell.imageView.af_setImageWithURL(NSURL(string: medium)!)
            } else if let full = arrayOfTvShows[indexPath.row].showOrMovie!.images!.poster!.full {
                cell.imageView.af_setImageWithURL(NSURL(string: full)!)
            } else {
                cell.imageView.image = UIImage(named: "No image")
            }
            
        } else {
            
            cell.remainingDaysStackView.hidden = true
            
            if let thumb = arrayOfMovies[indexPath.row].showOrMovie!.images!.poster!.thumb {
                cell.imageView.af_setImageWithURL(NSURL(string: thumb)!)
            } else if let medium = arrayOfMovies[indexPath.row].showOrMovie!.images!.poster!.medium {
                cell.imageView.af_setImageWithURL(NSURL(string: medium)!)
            } else if let full = arrayOfMovies[indexPath.row].showOrMovie!.images!.poster!.full {
                cell.imageView.af_setImageWithURL(NSURL(string: full)!)
            } else {
                cell.imageView.image = UIImage(named: "No image")
            }
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if segmentedControl.selectedSegmentIndex == 0 {
            performSegueWithIdentifier("ShowEpisodeList", sender: nil)
        } else {
            performSegueWithIdentifier("ShowMovieDetails", sender: nil)
        }
    }
    
    func showSimpleAlert(title: String, message: String, buttonText: String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowEpisodeList" {
            let vc = segue.destinationViewController as! TableShowsViewController
            let indexPath = collectionView.indexPathsForSelectedItems()
            vc.tvShow = arrayOfTvShows[indexPath![0].row].showOrMovie!
        } else if segue.identifier == "ShowMovieDetails"{
            let vc = segue.destinationViewController as! MovieEpisodeDetailsViewController
            let indexPath = collectionView.indexPathsForSelectedItems()
            vc.showOrMovie = arrayOfMovies[indexPath![0].row].showOrMovie!
        }
    }
    
    
}