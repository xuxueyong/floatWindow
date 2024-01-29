//
//  ViewController.swift
//  FloatWindowDemo
//
//  Created by 徐雪勇 on 2024/1/24.
//

import UIKit

extension ViewController {
    enum Constants {
        static let cancelViewSide: CGFloat = 160
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.height
        static let floatViewSide: CGFloat = 80
    }
}

class ViewController: UIViewController {
    
    var floatWindow: FloatWindow?
    
    lazy var floatView: WMDragView = {
        let view = WMDragView(frame: CGRect(origin: .zero, size: CGSize(width: Constants.floatViewSide, height: Constants.floatViewSide)))
        view.isKeepBounds = true
        view.freeRect = CGRect(x: 16, y: 40, width: Constants.screenWidth - 16 - 16, height: Constants.screenHeight - 40 - 40)
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = Constants.floatViewSide * 0.5
        view.center = self.view.center
        view.clipsToBounds = true
        return view
    }()
    
    lazy var cancelCircleView: UIView = {
        let view = CancelCircleView(frame: CGRect(x: Constants.screenWidth, y: Constants.screenHeight, width: Constants.cancelViewSide, height: Constants.cancelViewSide))
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addNewWindow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let keyWindow = UIApplication.shared.windows.first {
            keyWindow.addSubview(cancelCircleView)
            keyWindow.addSubview(floatView)
            
            floatView.beginDragBlock = {[weak self] _ in
                self?.showCancelView()
            }
            
            
            
            floatView.duringDragBlock = {[weak self] floatView in
                // 判断是否放大
                //两个圆心的距离 <= 两个半径只差；说明了floatingBtn可以移除了
                guard let center = floatView?.center else { return }
                let distance = sqrt(pow(Constants.screenWidth - center.x, 2) + pow(Constants.screenHeight - center.y, 2))
                
                if (distance <= Constants.cancelViewSide - Constants.floatViewSide * 0.5) {
                    self?.cancelCircleView.transform = CGAffineTransformMakeScale(1.2, 1.2)
                    let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
                    impactGenerator.impactOccurred()
                } else {
                    self?.cancelCircleView.transform = CGAffineTransformIdentity
                }
            }
            
            floatView.endDragBlock = {[weak self] floatView in
                self?.hiddenCancelView()
                guard let center = floatView?.center else { return }
                let distance = sqrt(pow(Constants.screenWidth - center.x, 2) + pow(Constants.screenHeight - center.y, 2))
                
                if (distance <= Constants.cancelViewSide - Constants.floatViewSide * 0.5) {
                    floatView?.removeFromSuperview()
                } else {
                    self?.cancelCircleView.transform = CGAffineTransformIdentity
                }
            }
        }
    }
    
    private func showCancelView() {
        UIView.animate(withDuration: 0.3) {
            self.cancelCircleView.frame = CGRect(x: Constants.screenWidth - Constants.cancelViewSide, y: Constants.screenHeight - Constants.cancelViewSide, width: Constants.cancelViewSide, height: Constants.cancelViewSide)
        }
    }
    
    private func hiddenCancelView() {
        UIView.animate(withDuration: 0.3) {
            self.cancelCircleView.frame = CGRect(x: Constants.screenWidth, y: Constants.screenHeight, width: Constants.cancelViewSide, height: Constants.cancelViewSide)
        }
    }
    
    func addNewWindow() {
        let edgeInsets: UIEdgeInsets = .init(top: 100, left: 16, bottom: 100, right: 16)
        let viewModel = FloatWindow.ViewModel(edgeInsets: edgeInsets,image: UIImage(named: "icon-1024")!)
        let floatSide: CGFloat = 80
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let floatWindow = FloatWindow(viewModel: viewModel, frame: CGRect(x: screenWidth - floatSide, y: screenHeight - floatSide, width: floatSide, height: floatSide))
        floatWindow.windowLevel = .alert
        floatWindow.rootViewController = UIViewController()
        floatWindow.backgroundColor = .clear
        floatWindow.isHidden = false
        self.floatWindow = floatWindow
        floatWindow.tapClosure = { window in
//            window.isHidden = true
            print("点击了window");
        }
    }
}

