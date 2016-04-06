//
//  CollectionViewCellForActors.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 04/03/16.
//  Copyright © 2016 Xavi. All rights reserved.
//

import UIKit

class CollectionViewCellForActors: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
