//
//  FloatWindow.swift
//  FloatWindowDemo
//
//  Created by 徐雪勇 on 2024/1/24.
//

import UIKit

class FloatWindow: UIWindow {
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = self.bounds.width * 0.5
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = self.bounds.width * 0.5
        return imageView
    }()
    
    var viewModel: ViewModel {
        didSet {
            applyViewModel()
        }
    }
    
    var tapClosure: ((_ window: FloatWindow) -> Void)?
    
    var beginDragClosure: ((_ window: FloatWindow) -> Void)?
    var duringDragClosure: ((_ window: FloatWindow) -> Void)?
    var endDragClosure: ((_ window: FloatWindow) -> Void)?
    
    var startPoint: CGPoint = .zero
    
    init(viewModel: ViewModel, frame: CGRect) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setupViews()
        applyViewModel()
        addGestures()
        setCornerRadiusAndShadow()
    }
    
    private func setupViews() {
        containerView.frame = self.bounds
        addSubview(containerView)
        imageView.frame = containerView.bounds
        containerView.addSubview(imageView)
    }
    
    private func applyViewModel() {
        imageView.image = viewModel.image
        let edgeInsets = viewModel.edgeInsets
        let right = edgeInsets.right
        let bottom = edgeInsets.bottom
        self.frame.origin.x = UIScreen.main.bounds.width - right - self.bounds.width
        self.frame.origin.y = UIScreen.main.bounds.height - bottom - self.bounds.height
        
        if viewModel.isKeepToBounds {
            keepToBounds()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
