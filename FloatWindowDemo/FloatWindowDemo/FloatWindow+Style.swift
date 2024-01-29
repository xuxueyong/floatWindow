//
//  FloatWindow+Style.swift
//  FloatWindowDemo
//
//  Created by 徐雪勇 on 2024/1/25.
//

import UIKit

extension FloatWindow {
    func setCornerRadiusAndShadow() {
        containerView.layer.masksToBounds = false
        let shadows = UIView()
        shadows.frame = self.containerView.frame
        shadows.clipsToBounds = false
        self.insertSubview(shadows, belowSubview: self.containerView)

        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 24.43)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0.071, green: 0.078, blue: 0.086, alpha: 0.05).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 28
        layer0.shadowOffset = CGSize(width: 0, height: 9)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)

        let shadowPath1 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 24.43)
        let layer1 = CALayer()
        layer1.shadowPath = shadowPath1.cgPath
        layer1.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        layer1.shadowOpacity = 1
        layer1.shadowRadius = 16
        layer1.shadowOffset = CGSize(width: 0, height: 6)
        layer1.bounds = shadows.bounds
        layer1.position = shadows.center
        shadows.layer.addSublayer(layer1)

        let shadowPath2 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 24.43)
        let layer2 = CALayer()
        layer2.shadowPath = shadowPath2.cgPath
        layer2.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.11).cgColor
        layer2.shadowOpacity = 1
        layer2.shadowRadius = 6
        layer2.shadowOffset = CGSize(width: 0, height: 3)
        layer2.bounds = shadows.bounds
        layer2.position = shadows.center
        shadows.layer.addSublayer(layer2)

        let shapes = UIView()
        shapes.frame = self.containerView.frame
        shapes.clipsToBounds = true
        self.insertSubview(shadows, aboveSubview: shadows)

        let layer3 = CALayer()
        layer3.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer3.bounds = shapes.bounds
        layer3.position = shapes.center
        shapes.layer.addSublayer(layer3)
        shapes.layer.cornerRadius = 24.43
    }
}
