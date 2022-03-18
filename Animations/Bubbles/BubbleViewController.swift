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
    
    private var pushBehavior: UIPushBehavior?
    
    private var snapBehavior: UISnapBehavior?
    
    private var attach: UIAttachmentBehavior?
    
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
        
        for _ in 0...30 {
            let bubble = BubbleView(radius: CGFloat(arc4random_uniform(20))+20, center: CGPoint(x: CGFloat(arc4random_uniform(1000)), y: CGFloat(arc4random_uniform(1000))))
            bubbles.append(bubble)
            view.addSubview(bubble)
        }
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panIsTriggered(gesture:)))
        view.addGestureRecognizer(panGesture!)
        
        
        animator = UIDynamicAnimator(referenceView: view)
        
        guard let animator = animator else {
            return
        }

        let collisionBehavior = UICollisionBehavior(items: bubbles)
        //collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .items
        animator.addBehavior(collisionBehavior)


        let fieldBehavior = UIFieldBehavior.springField()
        fieldBehavior.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        fieldBehavior.region = UIRegion(size: CGSize(width: 1100, height: 1100))
        fieldBehavior.strength = 8
        animator.addBehavior(fieldBehavior)
        
        let bubbleProperties = UIDynamicItemBehavior(items: bubbles)
        bubbleProperties.allowsRotation = false
        bubbleProperties.resistance = 8
        bubbleProperties.elasticity = 1
        
        animator.addBehavior(bubbleProperties)
        

        bubbles.forEach { fieldBehavior.addItem($0) }
        
        //animator.setValue(true, forKey: "debugEnabled")
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
            if let fbv = focusedBubble {
                view.bringSubviewToFront(fbv)
                
                if(  self.attach != nil ) { self.animator!.removeBehavior(attach!); self.attach = nil; }


                                self.attach = UIAttachmentBehavior(item: fbv, attachedToAnchor: touchPoint );
                                self.animator!.addBehavior(self.attach!);
                                self.attach!.damping = 1;
                                self.attach!.length = 1;

            }
            
            
            
        case .changed:
            guard let focusedBubble = focusedBubble else {
                return
            }
            
            let translation = gesture.translation(in: view)
            let location = gesture.location(in: view)
            
            self.attach!.anchorPoint = location;
            
            
            gesture.setTranslation(.zero, in: view)
        case .ended, .cancelled, .failed:
            if let _ = focusedBubble {
                self.focusedBubble = nil
            }
            
            if let _ = attach {
                self.animator!.removeBehavior(attach!);
                self.attach = nil;
            }
            
            
            
            
        case .possible: print("do not know what is this case ")
        @unknown default:
            fatalError()
        }
        
    }
    
    private func createBehaviors() {
        
        
    }

}
