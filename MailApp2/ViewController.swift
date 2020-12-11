//
//  ViewController.swift
//  MailApp2
//
//  Created by gtk on 2020/12/10.
//

import UIKit

class ViewController: UINavigationController {
    
    override func viewDidLoad() {
        let ad = UIApplication.shared.delegate as? AppDelegate
        guard ad?.persistentContainer != nil else {
            fatalError("can't get persistentContainer from AppDelegate")
        }
    }
    
}

