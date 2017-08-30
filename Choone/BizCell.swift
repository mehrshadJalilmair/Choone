//
//  BizCell.swift
//  Choone
//
//  Created by Mehrshad Jalilmasir on 9/24/16.
//  Copyright © 2016 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class BizCell: UITableViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var _image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var rule: UILabel!
    
    var biz : Biz!{
        
        didSet{
            
            UpdateUI()
        }
    }
    
    func UpdateUI()
    {
        _image.layer.cornerRadius = 10
        _image.clipsToBounds = true
        _image.layer.borderWidth = 0.5
        _image.layer.borderColor = UIColor.clear.cgColor
        
        background.layer.cornerRadius = 3.0
        background.layer.masksToBounds = false
        background.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        background.layer.shadowOffset = CGSize(width: 0, height: 0)
        background.layer.shadowOpacity = 0.5
        
        _image.image = UIImage(named: biz.imageAddress)
        
        name.text = biz.Name
        
        distance.text = biz.Address
        
        rule.text = biz.p_rules[0].name + ": " + biz.p_rules[0].explain//case and complete
    }
}
