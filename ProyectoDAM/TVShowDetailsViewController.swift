//
//  TVShowDetailsViewController.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 04/03/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SafariServices

class TVShowDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var showTitle: UINavigationItem!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showDescription: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var show: ShowOrMovie?
    var arrayOfPeople = [People]()
    var arrayOfCast = [Cast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTitle.title = show!.title!
        showImage.af_setImageWithURL(NSURL(string: show!.images!.poster!.thumb!)!)
        if let _ = show!.overview {
            showDescription.text = show!.overview!
        } else {
            showDescription.text = "Sorry, there isn't an overview yet :("
        }
        
        let hudView = HudView.hudInView(view,animated: true)
        Alamofire.request(.GET, "https://api-v2launch.trakt.tv/shows/\(show!.ids!.trakt!)/people?extended=images", headers: Helper().getApiHeaders()).responseJSON{ response in
            switch response.result {
            case .Success (let JSON):
                if let dict = JSON as? [String:AnyObject] {
                    self.arrayOfPeople.append(People(dictionary: dict)!)
                    for elem in self.arrayOfPeople[0].cast! {
                        self.arrayOfCast.append(elem)
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
    @IBAction func closeView(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if arrayOfCast.count != 0 {
            return arrayOfCast.count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCellForActors", forIndexPath: indexPath) as! CollectionViewCellForActors
        cell.imageView.image = UIImage(named: "Trakt")
        
        if arrayOfCast.count != 0 {
            let elem = arrayOfCast[indexPath.row]
            if let headShot = elem.person!.images!.headshot!.thumb {
                cell.imageView.af_setImageWithURL(NSURL(string: headShot)!)
            } else {
                cell.imageView.image = UIImage()
            }
            
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let IMDBId = arrayOfCast[indexPath.row].person!.ids!.imdb {
            let svc = SFSafariViewController(URL: NSURL(string: "http://www.imdb.com/name/\(IMDBId)/")!)
            self.presentViewController(svc, animated: true, completion: nil)
        } else {
            showSimpleAlert("Woops :(", message: "\(arrayOfCast[indexPath.row].person!.name!) doesn't have an IMDB page.", buttonText: "Try another one.")
        }
    }
    
    func showSimpleAlert(title: String, message: String, buttonText: String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
