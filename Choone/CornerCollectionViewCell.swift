//
//  CornerCollectionViewCell.swift
//  StickyCollectionView
//
//  Created by Bogdan Matveev on 02/02/16.
//  Copyright © 2016 Bogdan Matveev. All rights reserved.
//

import UIKit

class CornerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backingView: UIView!
    @IBOutlet weak var _image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var rule: UILabel!
    
    var color: UIColor? {
        didSet {
            backingView.backgroundColor = color
        }
    }
    
    var biz:Biz!
    {
        didSet{
            
            UpdateUI()
        }
    }
    func UpdateUI(){
        
        backingView.layer.cornerRadius = 12
        backingView.layer.masksToBounds = true
        
        _image.layer.cornerRadius = 10
        _image.clipsToBounds = true
        _image.layer.borderWidth = 0.5
        _image.layer.borderColor = UIColor.clearColor().CGColor
        
        _image.image = UIImage(named: "2")
        
        name.text = biz.Name
        
        distance.text = "فاصله کیلومتر"
        
        rule.text = biz.p_rules[0].name + ": " + biz.p_rules[0].explain//case and complete
    }
}
