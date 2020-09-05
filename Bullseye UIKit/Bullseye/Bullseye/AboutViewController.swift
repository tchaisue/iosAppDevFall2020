//
//  AboutViewController.swift
//  Bullseye
//
//  Created by Tanarut Chaisuesomboon on 9/4/20.
//  Copyright © 2020 Tanarut Chaisuesomboon. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "Bullseye",
                                     withExtension: "html") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

}
