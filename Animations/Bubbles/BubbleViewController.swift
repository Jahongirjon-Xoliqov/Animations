//
//  BubbleViewController.swift
//  Animations
//
//  Created by Administrator on 14/03/22.
//

import UIKit

class BubbleViewController: UIViewController {

    private var panGesture: UIPanGestureRecognizer?
    
    private var animator: UIDynamicAnimator?
    
    private var bubbles: [BubbleView] = []
    
    private var focusedBubble: BubbleView?
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        bubbles.append(BubbleView(radius: 50, center: CGPoint(x: 200, y: 200)))
        bubbles.append(BubbleView(radius: 50, center: CGPoint(x: 200, y: 500)))
     
        bubbles.forEach { view.addSubview($0) }
        
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panIsTriggered(gesture:)))
        view.addGestureRecognizer(panGesture!)
        
        
        animator = UIDynamicAnimator(referenceView: view)
        createBehaviors()
        
    }
    
    @objc private func panIsTriggered(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            
            let touchPoint = gesture.location(in: view)
            bubbles.forEach {
                if $0.contains(touchPoint) {
                    focusedBubble = $0
                }
            }
        case .changed:
            guard let focusedBubble = focusedBubble else {
                return
            }
            
            let translation = gesture.translation(in: view)
            focusedBubble.move(to: translation)
            
            gesture.setTranslation(.zero, in: view)
            
        case .ended, .cancelled, .failed:
            focusedBubble = nil
        case .possible: print("do not know what is this case ")
        @unknown default:
            fatalError()
        }
        
    }
    
    private func createBehaviors() {
        guard let animator = animator else {
            return
        }
        
        let collisionBehavior = UICollisionBehavior(items: bubbles)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .everything
        animator.addBehavior(collisionBehavior)
        
        let gravityBehavior = UIGravityBehavior(items: bubbles)
        animator.addBehavior(gravityBehavior)
        
    }

}
