//
//  FormerViewController.swift
//  Animations
//
//  Created by Administrator on 17/03/22.
//

import UIKit

class FormerViewController: UIViewController {

    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func goonButtonTapped(_ sender: UIButton) {
        let vc = DroppableViewController()
        vc.view.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0)
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = vc
        present(vc, animated: true)
    }
    
}
