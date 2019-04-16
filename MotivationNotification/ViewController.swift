//
//  ViewController.swift
//  MotivationNotification
//
//  Created by Prudhvi Gadiraju on 4/16/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var quote: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let quotes = Bundle.main.decode([Quote].self, from: "quotes.json")
        let pictures = Bundle.main.decode([String].self, from: "pictures.json")
        
        print(quotes)
        print(pictures)
    }


}

