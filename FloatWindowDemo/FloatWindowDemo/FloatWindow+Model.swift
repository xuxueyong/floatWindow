//
//  FloatView+Model.swift
//  FloatWindowDemo
//
//  Created by 徐雪勇 on 2024/1/24.
//

import UIKit

extension FloatWindow {
    enum DragDirection {
        case all
        case horizontal
        case vertical
    }
}

extension FloatWindow {
    struct ViewModel {
        /// 拖动方向
        let dragDirection: DragDirection
        /// 是否可拖动
        let dragable: Bool
        /// 拖动区域
        let edgeInsets: UIEdgeInsets
        /// 图片
        let image: UIImage
        /// 是否黏贴边缘 （可拖动区域的边缘）
        let isKeepToBounds: Bool
        
        init(
            dragDirection: DragDirection = .all,
            dragable: Bool = true,
            edgeInsets: UIEdgeInsets = .zero,
            image: UIImage,
            isKeepToBounds: Bool = true,
            displayCancelCircle: Bool = true
        ) {
            self.dragDirection = dragDirection
            self.dragable = dragable
            self.edgeInsets = edgeInsets
            self.image = image
            self.isKeepToBounds = isKeepToBounds
        }
    }
}
