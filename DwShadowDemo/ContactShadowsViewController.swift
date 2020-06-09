//
//  ContactShadowsViewController.swift
//  DwShadowDemo
//
//  Created by 吴迪玮 on 2020/6/9.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

class ContactShadowsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 阴影的厚度
        let size: CGFloat = 20
        // 阴影在下方的距离
        let distance: CGFloat = 80
        let rect = CGRect(
            x: -size,
            y: imageView.frame.height - (size * 0.4) + distance,
            width: imageView.frame.width + size * 2,
            height: size
        )

        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 7
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath
        imageView.layer.masksToBounds = false
    }

}
