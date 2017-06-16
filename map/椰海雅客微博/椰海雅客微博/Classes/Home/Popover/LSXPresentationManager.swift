//
//  LSXPresentationManager.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit
import QorumLogs

class LSXPresentationManager: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {
    private var isPresent:Bool = false
    private let arrowleftOffset:CGFloat = 30
    private let arrowrightOffset:CGFloat = 20
    var presentAreaSize:CGSize?
    var sourceRect:CGRect?
    var popoverArrowDirection:PopoverArrowDirection?
    weak var delegate:LSXPresentationManagerDelegate?
//MARK: 私有函数 
    private func anchorPointLocation(rect:CGRect,size:CGSize) -> CGPoint {
        var point = CGPoint()
        
        point.y = rect.origin.y + rect.size.height + 20
        point.x = rect.origin.x + rect.size.width * 0.5
        
        guard let type = popoverArrowDirection else {
            point.x = point.x - size.width * 0.5
            
            return point
        }
        
        
        switch type {
        case .middle:
            point.x = point.x - size.width * 0.5
        case .left:
            point.x = point.x - arrowleftOffset
        case .right:
            point.x = point.x - size.width + arrowrightOffset
        }
        
        return point
    }
//MARK: 转场相关代理方法->UIViewControllerTransitioningDelegate
    //: 负责自定义转场的对象
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?{
        let controller = LSXPresentationController(presentedViewController: presented, presenting: presenting)
        
        guard let areaSize = presentAreaSize else {
            return controller
        }
        
        controller.presentAreaSize = areaSize
  
        guard let rect = sourceRect else {
            return controller
        }

       controller.presentLocation = anchorPointLocation(rect: rect,size: areaSize)
        
        
        return controller
    }
    //: 负责实现自定义转场动画的对象(动画如何出现)
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        isPresent = true
        delegate?.animationControllerPresented(manager: self)
        
        return self;
    }
    //: 负责实现自定义转场动画的对象(动画如何消失)
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        isPresent = false
        delegate?.animationControllerDismissed(manager: self)
        
        return self;
    }
    
//MARK: 转场动画相关的代理方法-> UIViewControllerAnimatedTransitioning
    //: 转场动画展现与消失时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        return 0.3
    }
    //: 转场动画展现与消失的实现方法
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        
        if isPresent {
            willPresentedAnimationTransition(using: transitionContext)
        }else{
            willDismissedPresentedAnimationTransition(using: transitionContext)
        }
    }
    
    //: 转场动画展现
    private func willPresentedAnimationTransition(using transitionContext: UIViewControllerContextTransitioning){
        
        guard let toView = transitionContext.view(forKey:.to) else {
            return
        }
        
        //: 添加展示的view
        transitionContext.containerView.addSubview(toView)
        
        toView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            //: 恢复
            toView.transform = .identity
        }) { (_) in
            //: 注意: 自定转场动画, 在执行完动画之后一定要告诉系统动画执行完毕了
            transitionContext.completeTransition(true)
        }
    }
    
    //: 转场动画消失
    private func willDismissedPresentedAnimationTransition(using transitionContext: UIViewControllerContextTransitioning){
        guard let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            //: 恢复
            fromView.transform = CGAffineTransform(scaleX: 1.0, y: 0.000001)
            fromView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        }) { (_) in
            //: 注意: 自定转场动画, 在执行完动画之后一定要告诉系统动画执行完毕了
            transitionContext.completeTransition(true)
        }
    }
}

protocol LSXPresentationManagerDelegate : NSObjectProtocol {
   func animationControllerPresented(manager:LSXPresentationManager) ->Void
    
   func animationControllerDismissed(manager:LSXPresentationManager) ->Void
}

