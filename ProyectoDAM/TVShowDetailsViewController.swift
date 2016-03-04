//
//  TVShowDetailsViewController.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 04/03/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import UIKit
import AlamofireImage

class TVShowDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var showTitle: UINavigationItem!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showDescription: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var show: ShowOrMovie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTitle.title = show!.title!
        showImage.af_setImageWithURL(NSURL(string: show!.images!.poster!.thumb!)!)
        if let _ = show!.overview {
            showDescription.text = show!.overview!
        } else {
            showDescription.text = "Sorry, there isn't an overview yet :("
        }
        
    }
    @IBAction func closeView(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCellForActors", forIndexPath: indexPath) as! CollectionViewCellForActors
        cell.imageView.image = UIImage(named: "Trakt")
        return cell
    }
}
