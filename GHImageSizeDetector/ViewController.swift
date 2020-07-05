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
        view.backgroundColor = .white
        let imageView = UIImageView(frame: CGRect(x: 50, y: 50, width: 250, height: 310))
        imageView.image = UIImage(named: "img")
        view.addSubview(imageView)
    }

}

