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
        print(NSHomeDirectory())
        
        print("start\(Date().timeIntervalSince1970)")
        for _ in 0...20000 {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
            imageView.image = UIImage(named: "img")
            view.addSubview(imageView)
        }
        print("start\(Date().timeIntervalSince1970)")

//        start1593833451.718289
//        start1593833453.404059

        
//        start1593833491.817353
//        start1593833492.784735
        
//        start1593833530.498569
//        start1593833531.277863
    }


}

