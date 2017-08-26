//
//  ViewSnapViewController.swift
//  SnapChat
//
//  Created by Deborah Graham on 8/21/17.
//  Copyright © 2017 Deborah Graham. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage


class ViewSnapViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = snap.descrip
        
        imageView.sd_setImage(with: URL(string: snap.imageURL), completed: nil)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("snaps").child(snap.key).removeValue()
        
        Storage.storage().reference().child("images").child("\(snap.uuid).jpg").delete(completion: nil)
    }

}
