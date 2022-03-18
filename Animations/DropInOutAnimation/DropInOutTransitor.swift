//
//  DropInOutTransitor.swift
//  Animations
//
//  Created by Administrator on 17/03/22.
//

import UIKit

class DropOutAnimator: UIDynamicBehavior {
    let duration: TimeInterval
    let isAppearing: Bool

    var transitionContext: UIViewControllerContextTransitioning?
    var hasElapsedTimeExceededDuration = false
    var finishTime: TimeInterval = 0.0
    var collisionBehavior: UICollisionBehavior?
    var attachmentBehavior: UIAttachmentBehavior?
    var animator: UIDynamicAnimator?

    init(duration: TimeInterval = 1.0,  isAppearing: Bool) {
        self.duration = duration
        self.isAppearing = isAppearing
        super.init()
    }
}

extension DropOutAnimator: UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Get relevant views and view controllers from transitionContext
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let fromView = fromVC.view,
              let toView = toVC.view else { return }
    
        let containerView = transitionContext.containerView
        let duration = self.transitionDuration(using: transitionContext)
    
        // Hold refrence to transitionContext to notify it of completion
        self.transitionContext = transitionContext
    
        // Create dynamic animator
        let animator = UIDynamicAnimator(referenceView: containerView)
        animator.delegate = self
        self.animator = animator
    
        // Presenting Animation
        if self.isAppearing {
            fromView.isUserInteractionEnabled = false
        
            // Position toView  just off-screen
            let fromViewInitialFrame = transitionContext.initialFrame(for: fromVC)
            var toViewInitialFrame = toView.frame
            toViewInitialFrame.origin.y -= toViewInitialFrame.height
            toViewInitialFrame.origin.x = fromViewInitialFrame.width * 0.5 - toViewInitialFrame.width * 0.5
            toView.frame = toViewInitialFrame
        
            containerView.addSubview(toView)
        
            // Prevent rotation and adjust bounce
            let bodyBehavior = UIDynamicItemBehavior(items: [toView])
            bodyBehavior.elasticity = 0.7
            bodyBehavior.allowsRotation = false
        
            // Add gravity at exaggerated magnitude so animation doesn't seem slow
            let gravityBehavior = UIGravityBehavior(items: [toView])
            gravityBehavior.magnitude = 10.0
        
            // Set collision bounds to include off-screen view and have collision in center
            // where our final view should come to rest
            let collisionBehavior = UICollisionBehavior(items: [toView])
            let insets = UIEdgeInsets(top: toViewInitialFrame.minY, left: 0.0, bottom: fromViewInitialFrame.height * 0.5 - toViewInitialFrame.height * 0.5, right: 0.0)
            collisionBehavior.setTranslatesReferenceBoundsIntoBoundary(with: insets)
            self.collisionBehavior = collisionBehavior
        
            // Keep track of finish time in case we need to end the animator befor the animator pauses
            self.finishTime = duration + (self.animator?.elapsedTime ?? 0.0)
        
            // Closure that is called after every "tick" of the animator
            // Check if we exceed duration
            self.action =
            { [weak self] in
                guard let strongSelf = self,
                  (strongSelf.animator?.elapsedTime ?? 0.0) >= strongSelf.finishTime else { return }
                strongSelf.hasElapsedTimeExceededDuration = true
                strongSelf.animator?.removeBehavior(strongSelf)
            }
        
            // `DropOutAnimator` is a composit behavior, so add child behaviors to self
            self.addChildBehavior(collisionBehavior)
            self.addChildBehavior(bodyBehavior)
            self.addChildBehavior(gravityBehavior)
        
            // Add self to dynamic animator
            self.animator?.addBehavior(self)
        }
        // Dismissing Animation
        else {
            
            // Create allow rotation and have a elastic item
            let bodyBehavior = UIDynamicItemBehavior(items: [fromView])
            bodyBehavior.elasticity = 0.8
            bodyBehavior.angularResistance = 5.0
            bodyBehavior.allowsRotation = true
        
            // Create gravity with exaggerated magnitude
            let gravityBehavior = UIGravityBehavior(items: [fromView])
            gravityBehavior.magnitude = 10.0
        
            // Collision boundary is set to have a floor just below the bottom of the screen
            let collisionBehavior = UICollisionBehavior(items: [fromView])
            let insets = UIEdgeInsets(top: 0.0, left: -1000, bottom: -225, right: -1000)
            collisionBehavior.setTranslatesReferenceBoundsIntoBoundary(with: insets)
            self.collisionBehavior = collisionBehavior
        
            // Attachment behavior so view will have effect of hanging from a rope
            let offset = UIOffset(horizontal: 70.0, vertical: fromView.bounds.height * 0.5)
            var anchorPoint = CGPoint(x: fromView.bounds.maxX - 40.0, y: fromView.bounds.minY)
            anchorPoint = containerView.convert(anchorPoint, from: fromView)
            let attachmentBehavior = UIAttachmentBehavior(item: fromView, offsetFromCenter: offset, attachedToAnchor: anchorPoint)
            attachmentBehavior.frequency = 3.0
            attachmentBehavior.damping = 3.0
            self.attachmentBehavior = attachmentBehavior
        
            // `DropOutAnimator` is a composit behavior, so add child behaviors to self
            self.addChildBehavior(collisionBehavior)
            self.addChildBehavior(bodyBehavior)
            self.addChildBehavior(gravityBehavior)
            self.addChildBehavior(attachmentBehavior)
        
            // Add self to dynamic animator
            self.animator?.addBehavior(self)
        
            // Animation has two parts part one is hanging from rope.
            // Part two is bouncying off-screen
            // Divide duration in two
            self.finishTime = (2.0 / 3.0) * duration + (self.animator?.elapsedTime ?? 0.0)
        
             // After every "tick" of animator check if past time limit
            self.action = { [weak self] in
                guard let strongSelf = self,
                  (strongSelf.animator?.elapsedTime ?? 0.0) >= strongSelf.finishTime else { return }
                strongSelf.hasElapsedTimeExceededDuration = true
                strongSelf.animator?.removeBehavior(strongSelf)
            }
        }
    
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            // Return the duration of the animation
            return self.duration
    }
}

extension DropOutAnimator: UIDynamicAnimatorDelegate {
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
      // Animator has reached stasis
        if self.isAppearing {
            // Check if we are out of time
            if self.hasElapsedTimeExceededDuration {
                // Move to final positions
                let toView = self.transitionContext?.viewController(forKey: .to)?.view
                let containerView = self.transitionContext?.containerView
                toView?.center = containerView?.center ?? .zero
                self.hasElapsedTimeExceededDuration = false
            }
            
            // Clean up and call completion
            self.transitionContext?.completeTransition(!(self.transitionContext?.transitionWasCancelled ?? false))
            self.childBehaviors.forEach { self.removeChildBehavior($0) }
            animator.removeAllBehaviors()
            self.transitionContext = nil
        } else {
            if let attachmentBehavior = self.attachmentBehavior {
                // If we have an attachment, we are at the end of part one and start part two.
                self.removeChildBehavior(attachmentBehavior)
                self.attachmentBehavior = nil
                animator.addBehavior(self)
                let duration = self.transitionDuration(using: self.transitionContext)
                self.finishTime = 1.0 / 3.0 * duration + animator.elapsedTime
            } else {
                // Clean up and call completion
                let fromView = self.transitionContext?.viewController(forKey: .from)?.view
                let toView = self.transitionContext?.viewController(forKey: .to)?.view
                fromView?.removeFromSuperview()
                toView?.isUserInteractionEnabled = true
                self.transitionContext?.completeTransition(!(self.transitionContext?.transitionWasCancelled ?? false))
                self.childBehaviors.forEach { self.removeChildBehavior($0) }
                animator.removeAllBehaviors()
                self.transitionContext = nil
            }
        }
    }
}
