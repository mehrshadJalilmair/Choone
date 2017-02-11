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
        _image.layer.borderColor = UIColor.clearColor().CGColor
        
        background.layer.cornerRadius = 3.0
        background.layer.masksToBounds = false
        background.layer.shadowColor = UIColor.blackColor().colorWithAlphaComponent(0.5).CGColor
        background.layer.shadowOffset = CGSize(width: 0, height: 0)
        background.layer.shadowOpacity = 0.5
        
        _image.image = UIImage(named: "2")
        
        name.text = biz.Name
        
        distance.text = "فاصله کیلومتر"
        
        rule.text = biz.p_rules[0].name + ": " + biz.p_rules[0].explain//case and complete
    }
}
