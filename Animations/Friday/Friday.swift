//
//  Friday.swift
//  Animations
//
//  Created by Administrator on 15/03/22.
//

import UIKit


class Friday: NSObject {
    
    static let coordinator = Coordinator()
    
}

class Coordinator: NSObject {
    
    private var main = UINavigationController()
    
    func createContainer(with vc: UIViewController) -> UINavigationController {
        main.setViewControllers([vc], animated: false)
        return main
    }
    
    func push(to vc: UIViewController, animate: Bool = true) {
        main.pushViewController(vc, animated: animate)
    }
    
    func moveAsRoot(to vc: UIViewController, animate: Bool = true) {
        main.viewControllers.insert(vc, at: 0)
        main.popToRootViewController(animated: animate)
    }
    
    func toRoot(animated: Bool = true) {
        main.popToRootViewController(animated: animated)
    }
    
    func vcsCount() -> Int {
        main.viewControllers.count
    }
    
    func insert(vc: UIViewController, at index: Int) {
        main.viewControllers.insert(vc, at: index)
    }
    
}

extension NSObject {
    func isNil(_ value: Any?) -> Bool {
        return value == nil
    }
}
