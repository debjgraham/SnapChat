//
//  SnapsViewController.swift
//  SnapChat
//
//  Created by Deborah Graham on 8/19/17.
//  Copyright © 2017 Deborah Graham. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var snaps : [Snap] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childAdded, with: { (snapshot) in
            
            let snap = Snap()
            let value = snapshot.value as? NSDictionary
            snap.imageURL = value?["imageURL"] as! String
            snap.from = value?["from"] as! String
            snap.descrip = value?["description"] as! String
            
            self.snaps.append(snap)
            
            self.tableView.reloadData()
            
        })
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let snap = snaps[indexPath.row]
        cell.textLabel?.text = snap.from
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        
        performSegue(withIdentifier: "viewsnapsegue", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewsnapsegue"{
            
            let nextVC = segue.destination as! ViewSnapViewController
            nextVC.snap = sender as! Snap!
        }
    }
}
