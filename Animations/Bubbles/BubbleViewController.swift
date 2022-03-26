//
//  BubbleViewController.swift
//  Animations
//
//  Created by Administrator on 14/03/22.
//

import UIKit

class BubbleViewController: UIViewController {
    
    
    @IBOutlet weak var clickmeButton: CButton!
    
    
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
        
        //let d = ++1++ +- ++1-- + 1-- - ++1
        //print(++d++)
        
        
        
        //beginDrawing()
        
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
    
    @IBAction func clickMeButtonTapped(_ sender: CButton) {
        
        sender.flipToRight()
        
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
                
                if(self.attach != nil) {
                    self.animator!.removeBehavior(attach!)
                    self.attach = nil
                }
                
                self.attach = UIAttachmentBehavior(item: fbv, attachedToAnchor: touchPoint )
                self.animator!.addBehavior(self.attach!)
                self.attach!.damping = 1
                self.attach!.length = 1

            }
            
        case .changed:
            
            guard focusedBubble != nil else {
                return
            }
            
            _ = gesture.translation(in: view)
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
            
        case .possible:
            print("do not know what is this case ")
        @unknown default:
            fatalError()
        }
        
    }

}

/*
 
 

protocol Drawable {
    func draw() -> String
}

struct Line: Drawable {
    var elements: [Drawable]
    func draw() -> String {
        elements.map { $0.draw() }.joined(separator: "")
    }
}

struct Space: Drawable {
    func draw() -> String {
        " "
    }
}

struct Text: Drawable {
    var content: String
    init(_ content: String) { self.content = content }
    func draw() -> String {
        content
    }
}

struct Stars: Drawable {
    var length: Int
    func draw() -> String { return String(repeating: "*", count: length) }
}

struct AllCaps: Drawable {
    var content: Drawable
    func draw() -> String { return content.draw().uppercased() }
}

@resultBuilder
struct DrawingBuilder {
    static func buildBlock(_ components: Drawable...) -> Drawable {
        print(components.forEach { print($0) })
        return Line(elements: components)
    }
}



extension BubbleViewController {
    
    func beginDrawing() {
        
        let line = Line(elements: [
        Stars(length: 3),
        Text("Hello"),
        Space(),
        Text("World"),
        Stars(length: 3)
        ])
        
        log(line.draw())
        
        makeGreeting(for: "hey")
    }
    
    func draw(@DrawingBuilder content: () -> Drawable) -> Drawable {
        content()
    }
    
    func makeGreeting(for name: String? = nil) {
        
        let line = draw {
            Stars(length: 3)
            Text("Hello")
            Space()
            Text("World")
            Stars(length: 3)
        }
        
        print(line.draw())
    }
    
}

*/
