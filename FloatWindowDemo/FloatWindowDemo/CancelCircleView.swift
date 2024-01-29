//
//  CancelCircleView.swift
//  FloatWindowDemo
//
//  Created by 徐雪勇 on 2024/1/29.
//

import UIKit

class CancelCircleView: UIView {

    private let kLeft_Gap: CGFloat = 10

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        if let ctx = UIGraphicsGetCurrentContext() {
            ctx.move(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
            ctx.addLine(to: CGPoint(x: 0, y: bounds.size.height))
            ctx.addArc(center: CGPoint(x: bounds.size.width, y: bounds.size.height),
                       radius: bounds.size.height,
                       startAngle: CGFloat.pi,
                       endAngle: CGFloat.pi + 2 * CGFloat.pi,
                       clockwise: false)
            
            ctx.setLineWidth(1)
            UIColor(red: 0.87, green: 0.33, blue: 0.35, alpha: 1.00).set()
            ctx.closePath()
            ctx.fillPath()
            
            if let image = UIImage(named: "floatBtn_cancel") {
                let imagePoint = CGPoint(x: (bounds.size.width + kLeft_Gap - image.size.width) / 2,
                                         y: (bounds.size.height - image.size.height) / 2)
                image.draw(at: imagePoint)
                
                let style = NSMutableParagraphStyle()
                style.alignment = .center
                
                
                
                let textRect = CGRect(x: kLeft_Gap,
                                      y: (bounds.size.height + image.size.height) / 2 + 5,
                                      width: bounds.size.width - kLeft_Gap,
                                      height: 40)
                
                let textAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 14),
                    .paragraphStyle: style,
                    .foregroundColor: UIColor(red: 0.98, green: 0.92, blue: 0.90, alpha: 1.00)
                ]
                
                ("取消浮窗" as NSString).draw(in: textRect, withAttributes: textAttributes)
            }
        }
    }
}
