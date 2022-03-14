//
//  BubbleView.swift
//  Animations
//
//  Created by Administrator on 15/03/22.
//

import UIKit

class BubbleView: UIView {
    
    var radius: CGFloat = 0
    
    convenience init(radius: CGFloat, center: CGPoint) {
        self.init(frame: CGRect(origin: CGPoint(x: center.x-radius, y: center.y-radius), size: CGSize(width: radius*2, height: radius*2)))
        
        self.radius = radius
        
        clipsToBounds = true
        layer.cornerRadius = radius
        
        backgroundColor = .random()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        radius = frame.size.radius
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        radius = 0
        
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }
    
}

extension BubbleView {
    
    func contains(_ point: CGPoint) -> Bool {
        
        let xOffset = abs(point.x-frame.midX)
        let yOffset = abs(point.y-frame.midY)
        
        if xOffset > radius { return false }
        if yOffset > radius { return false }
        
        ///pifagor help
        return xOffset * xOffset + yOffset * yOffset <= radius * radius
        
    }
    
    func move(to point: CGPoint) {
        frame.move(to: point)
    }
    
}
