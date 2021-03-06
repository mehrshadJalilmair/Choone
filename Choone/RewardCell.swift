//
//  RewardCell.swift
//  Choone
//
//  Created by Mehrshad Jalilmasir on 9/26/16.
//  Copyright © 2016 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit
import FoldingCell

protocol rewarding{
    
    func getReward(_ cell:RewardCell)
    func useReward(_ cell:RewardCell)
}

class RewardCell: FoldingCell {
    
    var delegate:rewarding!
    
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var ruleName: UILabel!
    @IBOutlet weak var usageBtn: UIButton!
    @IBOutlet weak var ruleNameFold: UILabel!
    @IBOutlet weak var ruleExplainFold: UILabel!
    
    var rule:PublicRule!{
        
        didSet{
            
            updateUI()
        }
    }
    
    func updateUI()
    {
        ruleName.text = rule.name
        ruleNameFold.text = rule.name
        ruleExplainFold.text = rule.explain
        point.text = rule.howMuch
    }
    
    override func awakeFromNib() {
        
        foregroundView.layer.cornerRadius = 5
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
    @IBAction func usePoints(_ sender: AnyObject) {
        
        
        delegate.useReward(self)
    }
    
    @IBAction func getPoints(_ sender: AnyObject) {
        
        delegate.getReward(self)
    }
}
