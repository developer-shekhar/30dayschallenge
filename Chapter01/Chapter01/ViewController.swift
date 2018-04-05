//
//  ViewController.swift
//  Chapter01
//
//  Created by mac3 on 05/04/18.
//  Copyright © 2018 technoscore. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {

    @IBOutlet weak var contactTableView: UITableView!
    var contacts = [HCContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactTableView.delegate = self
        contactTableView.dataSource = self
        
       let store = CNContactStore()
        //check if permission is granted or not
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        if authorizationStatus == .notDetermined {
            store.requestAccess(for: .contacts, completionHandler: { [weak self] authorized , error in
                if authorized {
                    //fetch contacts
                    self?.retriveContacts(fromStore: store)
                }
            })
            
        }else {
            //permission granted
            //retrive contacts
            retriveContacts(fromStore: store)
        }
        
    }

    func retriveContacts(fromStore store : CNContactStore){
        let containerId = store.defaultContainerIdentifier()
        let predicate = CNContact.predicateForContactsInContainer(withIdentifier: containerId)
        let keysToFetch =  [ CNContactGivenNameKey as CNKeyDescriptor,
                             CNContactFamilyNameKey as CNKeyDescriptor,
                             CNContactPhoneNumbersKey as CNKeyDescriptor,
                             CNContactImageDataKey as CNKeyDescriptor,
                             CNContactImageDataAvailableKey as CNKeyDescriptor
                             ]
        self.contacts = try! store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch).map({ (contact) -> HCContact in
                return HCContact(contact: contact)
        })
        
        DispatchQueue.main.async {
            [weak self] in self?.contactTableView.reloadData()
        }
        print(contacts)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController : UITableViewDataSource {
    
    //data souce delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell") as! ContactTableViewCell
        let contact = contacts[ indexPath.row]
          cell.nameLabel.text = "\(contact.givenName) \(contact.familyName)"
        contact.fetchImageIfNeeded() //fetch image data here in case prefatch won't work
        if let image = contact.contactImage{
            cell.contactImage.image = image
        }
        
        
        return cell
        
    }
   
    
}


extension ViewController : UITableViewDelegate {
    // tableview delegate
    
}
//prefetching of data
extension ViewController : UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            //implement prefetching
            let contact = contacts[indexPath.row]
            contact.fetchImageIfNeeded() //prefetch image data
            
        }
        
    }
    

    
}


