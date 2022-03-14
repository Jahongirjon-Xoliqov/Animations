//
//  Rect+Extension.swift
//  Animations
//
//  Created by Administrator on 15/03/22.
//

import UIKit


extension CGRect {
    mutating func move(to point: CGPoint) {
        origin.x += point.x
        origin.y += point.y
    }
}
