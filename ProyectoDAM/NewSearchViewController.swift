//
//  NewSearchViewController.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 10/04/16.
//  Copyright © 2016 Xavi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class NewSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var arrayOfTvShows = [ShowOrMovie]()
    var arrayOfMovies = [ShowOrMovie]()
    var arrayOfSearch = [Result]()
    var isSearching = false
    var typeOfElement = "show"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hudView = HudView.hudInView(view,animated: true)
        
        Alamofire.request(.GET, "https://api-v2launch.trakt.tv/shows/popular?extended=images&page=1&limit=99", headers: Helper().getApiHeaders()).responseJSON{ response in
            switch response.result {
            case .Success (let JSON):
                if let shows = JSON as? [[String:AnyObject]] {
                    for show in shows{
                        self.arrayOfTvShows.append(ShowOrMovie(dictionary: show)!)
                    }

                    
                    Alamofire.request(.GET, "https://api-v2launch.trakt.tv/movies/popular?extended=images&page=1&limit=99", headers: Helper().getApiHeaders()).responseJSON{ response in
                        switch response.result {
                        case .Success (let JSON):
                            if let movies = JSON as? [[String:AnyObject]] {
                                for movie in movies{
                                    self.arrayOfMovies.append(ShowOrMovie(dictionary: movie)!)
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
            case .Failure (let error):
                self.showSimpleAlert("¡Error!", message: "Ha habido un problema al realizar la petición al servidor. Vuelve a intentarlo en unos minutos.", buttonText: "Volver a intentarlo.")
                print("Request failed with error: \(error)")
            }
        }
    }
    
    @IBAction func closeSearchViewController(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func switchBetweenMoviesAndShows(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            typeOfElement = "show"
            collectionView.reloadData()
            if isSearching {
                performSearch(searchBar.text!)
            }
        } else {
            typeOfElement = "movie"
            collectionView.reloadData()
            if isSearching {
                performSearch(searchBar.text!)
            }
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            searchBar.resignFirstResponder()
            collectionView.reloadData()
        } else {
            isSearching = true
            performSearch(searchText)
        }
    }
    
    func performSearch(searchText: String) {
        if searchText.characters.count != 1 && searchText != " " {
            let urlToQuery = "https://api-v2launch.trakt.tv/search?query=\(searchText)&type=\(typeOfElement)&extended=images&page=1&limit=99".stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
            
            Alamofire.request(.GET, urlToQuery!, headers: Helper().getApiHeaders()).responseJSON{ response in
                switch response.result {
                case .Success (let JSON):
                    self.arrayOfSearch = []
                    if let inSearch = JSON as? [[String:AnyObject]] {
                        for search in inSearch{
                            self.arrayOfSearch.append(Result(dictionary: search)!)
                        }
                        self.collectionView.reloadData()
                    }
                    
                case .Failure (let error):
                    self.showSimpleAlert("¡Error!", message: "Ha habido un problema al realizar la petición al servidor. Vuelve a intentarlo en unos minutos.", buttonText: "Volver a intentarlo.")
                    print("Request failed with error: \(error)")
                }
            }
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0 {
            if isSearching {
                return arrayOfSearch.count
            } else {
                return arrayOfTvShows.count
            }
        } else {
            if isSearching {
                return arrayOfSearch.count
            } else {
                return arrayOfMovies.count
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCellDiscover", forIndexPath: indexPath) as! BasicCell
        cell.imageView.image = UIImage(named: "Grey background")
        
        if segmentControl.selectedSegmentIndex == 0 {
            
            if isSearching {
                if let thumb = arrayOfSearch[indexPath.row].showOrMovie!.images!.poster!.thumb {
                    cell.imageView.af_setImageWithURL(NSURL(string: thumb)!)
                } else if let medium = arrayOfSearch[indexPath.row].showOrMovie!.images!.poster!.medium {
                    cell.imageView.af_setImageWithURL(NSURL(string: medium)!)
                } else if let full = arrayOfSearch[indexPath.row].showOrMovie!.images!.poster!.full {
                    cell.imageView.af_setImageWithURL(NSURL(string: full)!)
                } else {
                    cell.imageView.image = UIImage(named: "No image")
                }
            } else {
                if let thumb = arrayOfTvShows[indexPath.row].images!.poster!.thumb {
                    cell.imageView.af_setImageWithURL(NSURL(string: thumb)!)
                } else if let medium = arrayOfTvShows[indexPath.row].images!.poster!.medium {
                    cell.imageView.af_setImageWithURL(NSURL(string: medium)!)
                } else if let full = arrayOfTvShows[indexPath.row].images!.poster!.full {
                    cell.imageView.af_setImageWithURL(NSURL(string: full)!)
                } else {
                    cell.imageView.image = UIImage(named: "No image")
                }
            }
            
        } else {
            
            if isSearching {
                if let thumb = arrayOfSearch[indexPath.row].showOrMovie!.images!.poster!.thumb {
                    cell.imageView.af_setImageWithURL(NSURL(string: thumb)!)
                } else if let medium = arrayOfSearch[indexPath.row].showOrMovie!.images!.poster!.medium {
                    cell.imageView.af_setImageWithURL(NSURL(string: medium)!)
                } else if let full = arrayOfSearch[indexPath.row].showOrMovie!.images!.poster!.full {
                    cell.imageView.af_setImageWithURL(NSURL(string: full)!)
                } else {
                    cell.imageView.image = UIImage(named: "No image")
                }
            } else {
                if let thumb = arrayOfMovies[indexPath.row].images!.poster!.thumb {
                    cell.imageView.af_setImageWithURL(NSURL(string: thumb)!)
                } else if let medium = arrayOfMovies[indexPath.row].images!.poster!.medium {
                    cell.imageView.af_setImageWithURL(NSURL(string: medium)!)
                } else if let full = arrayOfMovies[indexPath.row].images!.poster!.full {
                    cell.imageView.af_setImageWithURL(NSURL(string: full)!)
                } else {
                    cell.imageView.image = UIImage(named: "No image")
                }
            }
            
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if segmentControl.selectedSegmentIndex == 0 {
            performSegueWithIdentifier("DisplayShowDescription", sender: nil)
        } else {
            performSegueWithIdentifier("ShowMovieDetailsSearch", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DisplayShowDescription" {
            let vc = segue.destinationViewController as! TVShowDetailsViewController
            let indexPath = collectionView.indexPathsForSelectedItems()
            if isSearching {
                vc.show = arrayOfSearch[indexPath![0].row].showOrMovie!
                vc.comingFromDiscover = true
            } else {
                vc.show = arrayOfTvShows[indexPath![0].row]
                vc.comingFromDiscover = true
            }
            
            
            //TO-DO
            //This should display the TVShow gerenarl VC, not the episode list
            
            
        } else if segue.identifier == "ShowMovieDetailsSearch" {
            let vc = segue.destinationViewController as! MovieEpisodeDetailsViewController
            let indexPath = collectionView.indexPathsForSelectedItems()
            if isSearching {
                vc.movie = arrayOfSearch[indexPath![0].row]
            } else {
                let fakedResult = Result(type: arrayOfMovies[indexPath![0].row])
                vc.movie = fakedResult
            }
        }
        
    }

    
    func showSimpleAlert(title: String, message: String, buttonText: String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
