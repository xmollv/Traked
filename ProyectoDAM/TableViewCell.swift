//
//  TableViewCell.swift
//  ProyectoDAM
//
//  Created by Xavi Moll Villalonga on 25/01/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell{
    
    @IBOutlet weak var label: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = ""
    }
}