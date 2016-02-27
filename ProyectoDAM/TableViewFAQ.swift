//
//  TableViewFAQ.swift
//  ProyectoDAM
//
//  Created by Tania Fontcuberta Mercadal on 27/2/16.
//  Copyright © 2016 TaniaXavi. All rights reserved.
//

import UIKit


class TableViewFAQ: UITableViewCell{
    
    
    @IBOutlet weak var label: UILabel!
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = ""
    }
}