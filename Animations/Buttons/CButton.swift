//
//  CButton.swift
//  Animations
//
//  Created by Administrator on 26/03/22.
//

import UIKit

/*
 
 style: circled, custom radius, none
 text: font, color
 animation: flip to any side,
 
 */

class CButton: UIButton {
    
    private var bgLayer: CALayer?
    
    convenience init() {
        self.init()
        log("just init")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        log("coder")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        log("coder")
        
        bgLayer = CALayer()
        bgLayer?.backgroundColor = UIColor.random().cgColor
        
        
        if let blayer = bgLayer {
            layer.addSublayer(blayer)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgLayer?.frame = bounds
    }
    
}

protocol Drawable {
    func draw()
}

class UIElement: Drawable {
    
    var styles: [Drawable]
    
    init(styles: [Drawable]) {
        self.styles = styles
    }
    
    func draw() {
        styles.forEach { $0.draw() }
    }
    
}

class Circle: Drawable {
    func draw() {
        
    }
}




@resultBuilder
class CButtonBuilder {
    
    static func buildBlock(_ components: Drawable...) -> UIElement {
        let element = UIElement(styles: components)
        element.draw()
        return element
    }
    
}


//MARK: - Styling

extension CButton {
    
    func circle() {
        let bAnimation = CABasicAnimation(keyPath: "cornerRadius")
        bAnimation.duration = 1
        bAnimation.fromValue = 0
        bAnimation.toValue = bounds.height/2
        bAnimation.delegate = self
        bAnimation.fillMode = .forwards
        bAnimation.isRemovedOnCompletion = false
        bgLayer?.add(bAnimation, forKey: "cornerRadius")
    }
    
}

extension CButton: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
       
    }
    
}


//MARK: - Animations

extension CButton {
    
    func flipToRight() {
        
        /*
        var transform3D = CATransform3DIdentity
        transform3D.m34 = -1/500
        layer.sublayerTransform = transform3D
        
        
        
        UIView.animate(withDuration: 1) {
            
            if #available(iOS 13.0, *) {
                self.transform3D = CATransform3DRotate(transform3D, CGFloat.pi/3, 1, 1, 0)
            } else {
                // Fallback on earlier versions
            }
            
        }
         */
        
        /*
        UIView.animate(withDuration: 1) {
            if #available(iOS 13.0, *) {
                self.transform3D = CATransform3DRotate(transform3D, CGFloat.pi/3, 1, 1, 0)
            } else {
                // Fallback on earlier versions
            }
        } completion: { _ in
            self.circle()
        }
         */
        
        if #available(iOS 13.0, *) {
            bgLayer?.sublayerTransform = CATransform3DRotate(transform3D, CGFloat.pi/3, 1, 1, 0)
        } else {
            // Fallback on earlier versions
        }
        
        
        
    }
    
    
}
