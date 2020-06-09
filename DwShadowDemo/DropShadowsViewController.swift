//
//  DropShadowsViewController.swift
//  DwShadowDemo
//
//  Created by 吴迪玮 on 2020/6/9.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

class DropShadowsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        imageView.layer.shadowRadius = 10
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowPath = UIBezierPath(rect: imageView.bounds).cgPath
        imageView.layer.masksToBounds = false
    }
}
