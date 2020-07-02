//
//  ViewController.swift
//  GHImageSizeDetector
//
//  Created by Run Liao on 2020/7/2.
//  Copyright © 2020 Run Liao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img")
        imageView.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
        view.addSubview(imageView)
    }


}

