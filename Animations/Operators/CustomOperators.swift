//
//  CustomOperators.swift
//  Animations
//
//  Created by Administrator on 24/03/22.
//

import Foundation

struct Vector2D {
    var x: Double = 0.0
    var y: Double = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.y, y: left.y + right.y)
    }
    
    static func - (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.y, y: left.y + right.y)
    }
}


//let d = ++1++ +- ++1-- + 1-- - ++1
//print(++d++)

infix operator +- : AdditionPrecedence

extension Int {
    
    static postfix func ++ (value: Int) -> Int {
        return value + 1
    }
    
    static prefix func ++ (value: Int) -> Int {
        return value + 1
    }
    
    static func +- (right: Int, left: Int) -> Int {
        return right + left - left
    }
    
    static postfix func -- (value: Int) -> Int {
        return value - 1
    }
    
}

