//
//  ShadeFormViewController.swift
//  Animations
//
//  Created by Administrator on 17/03/22.
//

import UIKit

class ShadeFormViewController: UIViewController {

    var presentingAnimator: ShadeAnimator!
    var dismissingAnimator: ShadeAnimator!
    let shadeVC = ShadeViewController()
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentingAnimator = ShadeAnimator(isAppearing: true, presentingVC: self, presentedVC: shadeVC, transitionDelegate: self)
        dismissingAnimator = ShadeAnimator(isAppearing: false, presentingVC: self, presentedVC: shadeVC, transitionDelegate: self)
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .random()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        shadeVC.view.frame = view.frame
        
    }
}

extension ShadeFormViewController: UIViewControllerTransitioningDelegate
{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return EmptyAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return EmptyAnimator()
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
    {
        return presentingAnimator
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
    {
        return dismissingAnimator
    }
}
