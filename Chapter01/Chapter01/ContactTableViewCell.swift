//
//  ContactTableViewCell.swift
//  Chapter01
//
//  Created by mac3 on 05/04/18.
//  Copyright © 2018 technoscore. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contactImage: UIImageView!

    override func prepareForReuse() {
        contactImage.image = nil
        
    }
}
