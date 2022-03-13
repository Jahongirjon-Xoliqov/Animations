//
//  Temp2ViewController.swift
//  Animations
//
//  Created by Administrator on 14/03/22.
//

import UIKit

class Temp2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tap)
    }

    @objc private func tapped() {
        //Friday.coordinator.moveAsRoot(to: Temp3ViewController(nibName: "Temp3ViewController", bundle: nil), animate: true)
        Friday.coordinator.push(to: Temp3ViewController(nibName: "Temp3ViewController", bundle: nil))
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
