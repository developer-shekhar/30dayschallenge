//
//  HCContact.swift
//  Chapter01
//
//  Created by mac3 on 05/04/18.
//  Copyright © 2018 technoscore. All rights reserved.
//

import Foundation
import UIKit
import Contacts

class HCContact {
    private let contact : CNContact
    var contactImage : UIImage? //it can be null
    var givenName : String { return contact.givenName }
    var familyName : String { return contact.familyName }
    
    init(contact: CNContact) {
        self.contact = contact
    }
    func fetchImageIfNeeded() {
        if  let imageData = contact.imageData, contactImage == nil {
            contactImage = UIImage(data: imageData)
        }
    }
    
    
}
