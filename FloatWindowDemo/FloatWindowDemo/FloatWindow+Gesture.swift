//
//  FloatWindow+Gesture.swift
//  FloatWindowDemo
//
//  Created by 徐雪勇 on 2024/1/25.
//

import UIKit

extension FloatWindow {
    
    func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandle(ges:)))
        addGestureRecognizer(tapGesture)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandle(ges:)))
        addGestureRecognizer(panGesture)
    }
    
    @objc
    private func tapHandle(ges: UITapGestureRecognizer) {
        tapClosure?(self)
    }
    
    @objc
    private func panHandle(ges: UIPanGestureRecognizer) {
        guard viewModel.dragable else {
            return
        }
        switch ges.state {
        case .began:
            imageView.alpha = 0.8
            beginDragClosure?(self)
            ges.setTranslation(.zero, in: self)
            self.startPoint = ges.translation(in: self)
        case .changed:
            let point = ges.translation(in: self)
            var dx: CGFloat = 0
            var dy: CGFloat = 0
            switch viewModel.dragDirection {
            case .all:
                dx = point.x - startPoint.x
                dy = point.y - startPoint.y
            case .horizontal:
                dx = point.x - startPoint.x
                dy = 0
            case .vertical:
                dx = 0
                dy = point.y - startPoint.y
            }
            let newCenter = CGPoint(x: self.center.x + dx, y: self.center.y + dy)
            self.center = newCenter
            ges.setTranslation(.zero, in: self)
        case .ended:
            imageView.alpha = 1.0
            endDragClosure?(self)
            keepToBounds()
        default:
            break
        }
    }
    
    // 黏贴边界效果
    func keepToBounds() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let isLandsCape: Bool = screenWidth > screenHeight
        let left = isLandsCape ? viewModel.edgeInsets.top : viewModel.edgeInsets.left
        let right = isLandsCape ? viewModel.edgeInsets.bottom : viewModel.edgeInsets.right
        // 计算中心点
        let centerX = left + (screenWidth - left - right) / 2.0
        // 向右黏贴
        if self.frame.origin.x >= centerX {
            UIView.animate(withDuration: 0.2) {
                self.frame.origin.x = screenWidth - right - self.bounds.width
            }
        } else { // 向左黏贴
            UIView.animate(withDuration: 0.2) {
                self.frame.origin.x = left
            }
        }
        
        // 上面到滑动区域
        if (self.frame.origin.y < viewModel.edgeInsets.top) {
            UIView.animate(withDuration: 0.2) {
                self.frame.origin.y = self.viewModel.edgeInsets.top
            }
        }
        
        // 下面到滑动区域
        if (self.frame.origin.y > (screenHeight -  viewModel.edgeInsets.bottom - self.bounds.height)) {
            UIView.animate(withDuration: 0.2) {
                self.frame.origin.y = screenHeight - self.viewModel.edgeInsets.bottom - self.bounds.height
            }
        }
    }
}
