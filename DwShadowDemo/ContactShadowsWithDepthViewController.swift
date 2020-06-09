//
//  ContactShadowsWithDepthViewController.swift
//  DwShadowDemo
//
//  Created by 吴迪玮 on 2020/6/9.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

class ContactShadowsWithDepthViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // height 负数，光源在正面，阴影绘制在背影。正数，光源在背面，阴影绘制在前影
        let scale = CGSize(width: 0.8, height: -0.6)
        // 光源水平位置
        let offsetX: CGFloat = 100

        let shadowPath = UIBezierPath()
        shadowPath.move(to:
            CGPoint(
                x: 0,
                y: imageView.frame.height
            )
        )
        shadowPath.addLine(to:
            CGPoint(
                x: imageView.frame.width,
                y: imageView.frame.height
            )
        )
        shadowPath.addLine(to:
            CGPoint(
                x: imageView.frame.width * scale.width + offsetX,
                y: imageView.frame.height * (1 + scale.height)
            )
        )
        shadowPath.addLine(to:
            CGPoint(
                x: imageView.frame.width * (1 - scale.width) + offsetX,
                y: imageView.frame.height * (1 + scale.height)
            )
        )
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 7
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowPath = shadowPath.cgPath
        imageView.layer.masksToBounds = false
    }
}
