//
//  Color+Extension.swift
//  Animations
//
//  Created by Administrator on 15/03/22.
//

import UIKit

extension UIColor {
    
    static func random() -> UIColor {
        switch arc4random_uniform(6) {
        case 0: return .red
        case 1: return .blue
        case 2: return .green
        case 3: return .purple
        case 4: return .systemPink
        case 5: return .cyan
        default:
            return .black
        }
    }
    
}


