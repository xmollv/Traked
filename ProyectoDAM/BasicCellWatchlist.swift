//
//  BasicCell.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 13/01/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import UIKit

class BasicCellWatchslist: UICollectionViewCell{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var containerRemainingDays: UIView!
    @IBOutlet weak var labelRemainigDays: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
