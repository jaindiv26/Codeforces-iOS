//
//  DrawerPresentationController.swift
//  Codeforces
//
//  Created by Divyansh  Jain on 25/11/19.
//  Copyright © 2019 Divyansh  Jain. All rights reserved.
//

import Foundation
import UIKit

public enum DraweSnapPoint {
    case top
    case close
}

/// DrawerPresentationController is a UIPresentationController that allows
/// modals to be presented like a bottom sheet. The kind of presentation style
/// you can see on the Maps app on iOS.
///
/// Return a DrawerPresentationController in a UIViewControllerTransitioningDelegate.

public class DrawerPresentationController: UIPresentationController {
    
    public var blurEffectStyle: UIBlurEffect.Style = .light

    public var topGap: CGFloat = 88
    
    private var modalHeight: CGFloat = 0
    
    /// Toggle the bounce value to allow the modal to bounce when it's being
    /// dragged top, over the max width (add the top gap).
    public var bounce: Bool = false
    
    public var roundedCorners: UIRectCorner = [.topLeft, .topRight]
    
    /// Frame for the modally presented view.
    override public var frameOfPresentedViewInContainerView: CGRect {
        modalHeight = (self.containerView!.frame.height / 2) - self.topGap
        return CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height / 4), size: CGSize(width: (self.containerView!.frame.width), height: modalHeight))
    }
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: self.blurEffectStyle))
        blur.isUserInteractionEnabled = true
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blur.addGestureRecognizer(self.tapGestureRecognizer)
        return blur
    }()
    
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(self.dismiss))
    }()
    
    private lazy var panGesture: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.drag(_:)))
        return pan
    }()
    
    public convenience init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, blurEffectStyle: UIBlurEffect.Style = .light, topGap: CGFloat = 88) {
        self.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.blurEffectStyle = blurEffectStyle
        self.topGap = topGap
    }

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override public func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.alpha = 0
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.removeFromSuperview()
        })
    }
    
    override public func presentationTransitionWillBegin() {
        self.blurEffectView.alpha = 0
        // Add the blur effect view
        guard let presenterView = self.containerView else { return }
        presenterView.addSubview(self.blurEffectView)
        
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.alpha = 1
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
    }
    
    override public func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        guard let presentedView = self.presentedView else { return }
        
        presentedView.layer.masksToBounds = true
        presentedView.roundCorners(corners: self.roundedCorners, radius: UIConstants.cornerRadius)
        presentedView.addGestureRecognizer(self.panGesture)
    }
    
    override public func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        guard let presenterView = self.containerView else { return }
        sendToTop()
        self.blurEffectView.frame = presenterView.bounds
    }
    
    @objc func dismiss() {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    @objc func drag(_ gesture:UIPanGestureRecognizer) {
        guard let presentedView = self.presentedView else { return }
        switch gesture.state {
        case .changed:
            self.presentingViewController.view.bringSubviewToFront(presentedView)
            let translation = gesture.translation(in: self.presentingViewController.view)
            let y = presentedView.center.y + translation.y
            
            let preventBounce: Bool = self.bounce ? true : (y - (self.topGap / 2) > self.presentingViewController.view.center.y)
            // If bounce enabled or view went over the maximum y postion.
            if preventBounce {
                presentedView.center = CGPoint(x: self.presentedView!.center.x, y: y)
            }
            gesture.setTranslation(CGPoint.zero, in: self.presentingViewController.view)
        case .ended:
            let height = self.presentingViewController.view.frame.height
            let position = presentedView.convert(self.presentingViewController.view.frame, to: nil).origin.y
            if position < (height * 0.75 + CGFloat(self.topGap / 2)) {
                // TOP SNAP POINT
                self.sendToTop()
            } else {
                // BOTTOM SNAP POINT
                self.dismiss()
            }
            gesture.setTranslation(CGPoint.zero, in: self.presentingViewController.view)
        default:
            return
        }
    }
    
    func sendToTop() {
        guard let presentedView = self.presentedView else { return }
        let topYPosition: CGFloat = (self.presentingViewController.view.frame.height * 0.75 + CGFloat(self.topGap / 2))
        UIView.animate(withDuration: 0.25) {
            presentedView.center = CGPoint(x: presentedView.center.x, y: topYPosition)
        }
    }
}

private extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

