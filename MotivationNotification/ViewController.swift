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
    
    var shareQuote: Quote!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(updateQuote)))
    }

    @objc func updateQuote() {
        guard let backgroundImageName = images.randomElement() else { return }
        guard let selectedQuote = quotes.randomElement() else { return }
        shareQuote = selectedQuote
        
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
        
        let format = UIGraphicsImageRendererFormat()
        format.opaque = false
        let renderer = UIGraphicsImageRenderer(bounds: quoteRect.insetBy(dx: -30, dy: -30), format: format)
        
        quote.image = renderer.image(actions: { (context) in
            for i in 0...5 {
                context.cgContext.setShadow(offset: .zero, blur: CGFloat(i))
                str.draw(in: quoteRect)
            }
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateQuote()
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        let shareMessage = "\"\(shareQuote.text)\" - \(shareQuote.author)"
        let ac = UIActivityViewController(activityItems: [shareMessage], applicationActivities: nil)
        ac.popoverPresentationController?.sourceView = sender
        present(ac, animated: true)
    }
}

