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
    
    let quotes = Bundle.main.decode([Quote].self, from: "quotes.json")
    let images = Bundle.main.decode([String].self, from: "pictures.json")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

    }

    func updateQuote() {
        guard let backgroundImageName = images.randomElement() else { return }
        guard let selectedQuote = quotes.randomElement() else { return }
        
        background.image = UIImage(named: backgroundImageName)
        
        let insetAmount: CGFloat = 250
        let drawBounds = quote.bounds.inset(by: UIEdgeInsets(top: insetAmount, left: insetAmount, bottom: insetAmount, right: insetAmount))
        
        var quoteRect = CGRect(x: 0.0, y: 0.0, width: .greatestFiniteMagnitude, height: .greatestFiniteMagnitude)
        var fontSize: CGFloat = 120
        var font: UIFont!
        
        var attrs: [NSAttributedString.Key: Any]!
        var str: NSAttributedString!
        
        while true {
            font = UIFont(name: "Georgia-Italic", size: fontSize)
            attrs = [.font: font!, .foregroundColor: UIColor.white]
            
            str = NSAttributedString(string: selectedQuote.text, attributes: attrs)
            quoteRect = str.boundingRect(with: CGSize(width: drawBounds.width, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
            
            if quoteRect.height > drawBounds.height {
                fontSize -= 4
            } else {
                break
            }
        }
    }
}

