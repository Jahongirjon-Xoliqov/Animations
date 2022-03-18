//
//  DroppableViewController.swift
//  Animations
//
//  Created by Administrator on 17/03/22.
//

import UIKit

class DroppableViewController: UIViewController {

    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random()
    }

}

extension DroppableViewController: UIViewControllerTransitioningDelegate
{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DropOutAnimator(duration: 1.5, isAppearing: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DropOutAnimator(duration: 4.0, isAppearing: false)
    }
}
