//
//  BasicCellDiscover.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 24/01/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import UIKit

class BasicCellWatching: UICollectionViewCell{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var remainingDaysLabel: UILabel!
    @IBOutlet weak var containerRemainingDaysView: UIView!

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        remainingDaysLabel.text = ""
    }
}