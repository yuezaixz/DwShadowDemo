//
//  NeumorphicViewController.swift
//  DwShadowDemo
//
//  Created by 吴迪玮 on 2020/6/9.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

class NeumorphicViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        imageView.layer.borderColor = UIColor(white: 1.0, alpha: 0.2).cgColor
        imageView.layer.borderWidth = 1.0
        
        imageView.layer.shadowRadius = 6
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.layer.shadowOpacity = 1.0
        imageView.layer.shadowColor = UIColor(hex: 0x979490, alpha: 1.0).cgColor
        imageView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 6, y: 6, width: imageView.bounds.width, height: imageView.bounds.height)).cgPath
        imageView.layer.masksToBounds = false
        
        bgView.layer.shadowRadius = 4
        bgView.layer.shadowOffset = CGSize(width: -6, height: -6)
        bgView.layer.shadowOpacity = 1.0
        bgView.layer.shadowColor = UIColor(hex: 0xFFFFFF, alpha: 1).cgColor
        bgView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: imageView.bounds.width + 12, height: imageView.bounds.height + 12)).cgPath
        bgView.layer.masksToBounds = false
    }

}
