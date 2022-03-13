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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panIsTriggered(gesture:)))
        if !isNil(panGesture) {
            view.addGestureRecognizer(panGesture!)
        }
        
        animator = UIDynamicAnimator(referenceView: view)
        
    }
    
    @objc private func panIsTriggered(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            Friday.coordinator.push(to: TempViewController(nibName: "TempViewController", bundle: nil))
        case .changed: print("")
        case .ended, .cancelled, .failed: print("")
        case .possible: print("do not know what is this case ")
        @unknown default:
            fatalError()
        }
        
    }

}

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
    
    func magic() {
        let views = main.viewControllers.map { $0.view.snapshotView(afterScreenUpdates: true)!}
        let vc = BaseViewController(nibName: "BaseViewController", bundle: nil)
        vc.views = views
        moveAsRoot(to: vc)
        
    }
    
}

extension NSObject {
    func isNil(_ value: Any?) -> Bool {
        return value == nil
    }
}
