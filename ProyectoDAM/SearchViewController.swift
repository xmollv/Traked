//
//  SearchViewController.swift
//  ProyectoDAM
//
//  Created by Tania Fontcuberta Mercadal on 22/2/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBarDiscover: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var arrayOfTvShows = [ShowOrMovie]()
    var arrayOfMovies = [ShowOrMovie]()
    var arrayOfSearch = [Result]()
    var EMPTY = true;
    var searchActive = true;
    var SHOW = "show";
    var searchSerieMovie = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // navigationController?.navigationBarHidden = true
        searchBarDiscover.delegate = self
        
        let hudView = HudView.hudInView(view,animated: true)
        
        Alamofire.request(.GET, "https://api-v2launch.trakt.tv/shows/popular?extended=images&page=1&limit=99", headers: Helper().getApiHeaders()).responseJSON{ response in
            switch response.result {
            case .Success (let JSON):
                if let shows = JSON as? [[String:AnyObject]] {
                    for show in shows{
                        self.arrayOfTvShows.append(ShowOrMovie(dictionary: show)!)
                    }
                    self.collectionView.reloadData()
                    hudView.removeFromSuperview()
                }
            case .Failure (let error):
                self.showSimpleAlert("¡Error!", message: "Ha habido un problema al realizar la petición al servidor. Vuelve a intentarlo en unos minutos.", buttonText: "Volver a intentarlo.")
                print("Request failed with error: \(error)")
            }
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
    
    override func viewDidAppear(animated: Bool) {
        self.collectionView.resetScrollPositionToTop()
    }
    
    
    /* SEARCH BAR */
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        EMPTY = false;
        searchSerieMovie = searchText;
        search();
        if searchText.isEmpty {
            EMPTY = true;
            searchBar.resignFirstResponder()
            self.collectionView.reloadData()
            searchBar.showsCancelButton = false

        }
    }
    
    func search () {
        if searchSerieMovie.characters.count != 1 && searchSerieMovie != " "{
            let urlReq = "https://api-v2launch.trakt.tv/search?query=\(searchSerieMovie)&type=\(SHOW)&extended=images&page=1&limit=99"
            let urlNew:String = urlReq.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLQueryAllowedCharacterSet())!
            
            Alamofire.request(.GET, urlNew, headers: Helper().getApiHeaders()).responseJSON{ response in
                switch response.result {
                case .Success (let JSON):
                    self.arrayOfSearch = []
                    if let inSearch = JSON as? [[String:AnyObject]] {
                        for search in inSearch{
                            self.arrayOfSearch.append(Result(dictionary: search)!)
                        //    print(Result(dictionary: search)!.dictionaryRepresentation());
                        }
                        //print(self.searchSerieMovie)
                        self.collectionView.reloadData()
                    }
                    
                case .Failure (let error):
                    if self.EMPTY == false{
                        self.showSimpleAlert("¡Error!", message: "Ha habido un problema al realizar la petición al servidor. Vuelve a intentarlo en unos minutos.", buttonText: "Volver a intentarlo.")
                        print("Request failed with error: \(error)")
                    }
                }
            }
            
        }

    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        EMPTY = true;
        searchBar.resignFirstResponder()
        self.collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    /* */
    
    
    @IBAction func segmentedControlAction(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            SHOW = "show"
            search()
            collectionView.reloadData()
            self.collectionView.resetScrollPositionToTop()
        } else if sender.selectedSegmentIndex == 1 {
            SHOW = "movie"
            search()
            collectionView.reloadData()
            self.collectionView.resetScrollPositionToTop()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            if EMPTY == true{
                return arrayOfTvShows.count
            }else{
                return arrayOfSearch.count
            }
        } else {
            if EMPTY == true{
                return arrayOfMovies.count
            }else{
                return arrayOfSearch.count
            }
        }
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        searchBarDiscover.showsCancelButton = false
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BasicCellSearch", forIndexPath: indexPath) as! BasicCell
        
        cell.imageView.image = UIImage(named: "Grey background")
        
        if segmentedControl.selectedSegmentIndex == 0 {
            
            if EMPTY == true {
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
            else{
                
                if let thumb = arrayOfSearch[indexPath.row].showOrMovie!.images!.poster!.thumb {
                    cell.imageView.af_setImageWithURL(NSURL(string: thumb)!)
                } else if let medium = arrayOfSearch[indexPath.row].showOrMovie!.images!.poster!.medium {
                    cell.imageView.af_setImageWithURL(NSURL(string: medium)!)
                } else if let full = arrayOfSearch[indexPath.row].showOrMovie!.images!.poster!.full {
                    cell.imageView.af_setImageWithURL(NSURL(string: full)!)
                } else {
                    cell.imageView.image = UIImage(named: "No image")
                }
            }
            
        } else {
            
            if EMPTY == true {
                if let thumb = arrayOfMovies[indexPath.row].images!.poster!.thumb {
                    cell.imageView.af_setImageWithURL(NSURL(string: thumb)!)
                } else if let medium = arrayOfMovies[indexPath.row].images!.poster!.medium {
                    cell.imageView.af_setImageWithURL(NSURL(string: medium)!)
                } else if let full = arrayOfMovies[indexPath.row].images!.poster!.full {
                    cell.imageView.af_setImageWithURL(NSURL(string: full)!)
                } else {
                    cell.imageView.image = UIImage(named: "No image")
                }
            } else{
                if let thumb = arrayOfSearch[indexPath.row].showOrMovie!.images!.poster!.thumb {
                    cell.imageView.af_setImageWithURL(NSURL(string: thumb)!)
                } else if let medium = arrayOfSearch[indexPath.row].showOrMovie!.images!.poster!.medium {
                    cell.imageView.af_setImageWithURL(NSURL(string: medium)!)
                } else if let full = arrayOfSearch[indexPath.row].showOrMovie!.images!.poster!.full {
                    cell.imageView.af_setImageWithURL(NSURL(string: full)!)
                } else {
                    cell.imageView.image = UIImage(named: "No image")
                }
            }
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if segmentedControl.selectedSegmentIndex == 0 {
            performSegueWithIdentifier("ShowEpisodeList", sender: nil)
        } else {
            performSegueWithIdentifier("ShowMovieDetailsSearch", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowEpisodeList" {
            let vc = segue.destinationViewController as! TableShowsViewController
            let indexPath = collectionView.indexPathsForSelectedItems()
            vc.tvShow = arrayOfSearch[indexPath![0].row].showOrMovie!
            
        } else if segue.identifier == "ShowMovieDetailsSearch"{
            let vc = segue.destinationViewController as! MovieEpisodeDetailsViewController
            let indexPath = collectionView.indexPathsForSelectedItems()
             if EMPTY == true {
                //FIX THIS
                //vc.movie = arrayOfMovies[indexPath![0].row]
            } else{
                //FIX THIS
                //vc.movie = arrayOfSearch[indexPath![0].row].showOrMovie!
            }
        }
        
    }
    @IBAction func closeView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showSimpleAlert(title: String, message: String, buttonText: String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }


}
