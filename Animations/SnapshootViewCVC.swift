//
//  SnapshootViewCVC.swift
//  Animations
//
//  Created by Administrator on 14/03/22.
//

import UIKit

class SnapshootViewCVC: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = true
        layer.cornerRadius = 20
    }

    func add(v: UIView) {
        addSubview(v)
        v.frame = bounds
    }
}

extension SnapshootViewCVC {
    static let id = "SnapshootViewCVC"
    static func nib() -> UINib {
        UINib(nibName: id, bundle: nil)
    }
}
