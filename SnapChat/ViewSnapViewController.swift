//
//  ViewSnapViewController.swift
//  SnapChat
//
//  Created by Deborah Graham on 8/21/17.
//  Copyright © 2017 Deborah Graham. All rights reserved.
//

import UIKit

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = snap.descrip
        
    }

    

}
