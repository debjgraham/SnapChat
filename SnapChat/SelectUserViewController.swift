//
//  SelectUserViewController.swift
//  SnapChat
//
//  Created by Deborah Graham on 8/20/17.
//  Copyright © 2017 Deborah Graham. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    
    var imageURL = ""
    var descrip = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        Database.database().reference().child("users").observe(DataEventType.childAdded, with: { (snapshot) in
            let user = User()
            
            // Get user value
            let value = snapshot.value as? NSDictionary
            user.email = value?["email"] as? String ?? ""
            user.uid = snapshot.key
            //print(user.email)
            //print(user.uid)
            
            self.users.append(user)
            
            self.tableView.reloadData()
        })
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        
        let snap = ["from":user.email, "description":descrip, "imageURL":imageURL]
        
        Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        
        navigationController!.popToRootViewController(animated: true)
    }
}
