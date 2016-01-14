//
//  FirstViewController.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 21/12/15.
//  Copyright © 2015 TaniaXavi. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return arrayOfBadgesGlobal.count
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! BasicCell
        
        cell.imageView.image = UIImage(named: "first")
        cell.textLabel.text = "Test"
        
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
    
    
}