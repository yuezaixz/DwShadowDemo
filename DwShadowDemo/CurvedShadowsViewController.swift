//
//  CurvedShadowsViewController.swift
//  DwShadowDemo
//
//  Created by 吴迪玮 on 2020/6/9.
//  Copyright © 2020 davidandty. All rights reserved.
//

import UIKit

class CurvedShadowsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 曲形阴影的曲度
        let curve: CGFloat = 15

        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint.zero)
        shadowPath.addLine(to: CGPoint(
            x: imageView.frame.width,
            y: 0
        ))
        shadowPath.addLine(to: CGPoint(
            x: imageView.frame.width,
            y: imageView.frame.height + curve
        ))
        shadowPath.addCurve(
            to: CGPoint(
                x: 0,
                y: imageView.frame.height + curve
            ),
            controlPoint1: CGPoint(
                x: imageView.frame.width,
                y: imageView.frame.height
            ),
            controlPoint2: CGPoint(
                x: 0,
                y: imageView.frame.height
            )
        )
        imageView.layer.shadowPath = shadowPath.cgPath
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowOffset = CGSize(width: 0, height: 10)
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.masksToBounds = false
    }

}
