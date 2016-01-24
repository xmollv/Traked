//
//  BasicCellDiscover.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 24/01/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import UIKit

class BasicCellDiscover: UICollectionViewCell{
    
    @IBOutlet weak var imageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}