//
//  BaseViewController.swift
//  Animations
//
//  Created by Administrator on 14/03/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var views: [UIView]!
//    convenience init(views: [UIView]) {
//        self.init(nibName: self., bundle: <#T##Bundle?#>)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(SnapshootViewCVC.nib(), forCellWithReuseIdentifier: SnapshootViewCVC.id)
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
}

extension BaseViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        views.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SnapshootViewCVC.id, for: indexPath) as? SnapshootViewCVC {
            cell.add(v: views[indexPath.row])
            return cell
        }
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width-100, height: view.frame.height*0.7)
    }
    
}
