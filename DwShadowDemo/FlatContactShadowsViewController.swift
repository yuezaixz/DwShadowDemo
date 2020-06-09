//
//  FlatContactShadowsViewController.swift
//  DwShadowDemo
//
//  Created by 吴迪玮 on 2020/6/9.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

class FlatContactShadowsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let scale = CGSize(width: 1.5, height: 1.5)
        let offset = CGPoint(x: imageView.frame.width, y: -imageView.frame.height)

        let shadowPath = UIBezierPath()
        shadowPath.move(to:
            CGPoint(
                x: 0,
                y: imageView.frame.height + (copysign(1, scale.height) * copysign(1, offset.x) == 1 ? 0 : offset.y)
            )
        )
        shadowPath.addLine(to:
            CGPoint(
                x: imageView.frame.width,
                y: imageView.frame.height + (copysign(1, scale.height) * copysign(1, offset.x) == -1 ? 0 : offset.y)
            )
        )
        shadowPath.addLine(to:
            CGPoint(
                x: imageView.frame.width * scale.width + offset.x,
                y: imageView.frame.height * (1 + scale.height) + offset.y
            )
        )
        shadowPath.addLine(to:
            CGPoint(
                x: imageView.frame.width * (1 - scale.width) + offset.x,
                y: imageView.frame.height * (1 + scale.height) + offset.y
            )
        )
        imageView.layer.shadowPath = shadowPath.cgPath
        imageView.layer.shadowRadius = 0
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.masksToBounds = false
    }
}
