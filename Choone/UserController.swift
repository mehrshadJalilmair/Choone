//
//  UserController.swift
//  Choone
//
//  Created by Mehrshad Jalilmasir on 9/26/16.
//  Copyright © 2016 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class UserController: UIViewController {

    @IBOutlet weak var profileBg: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var segmentTab: UISegmentedControl!
    
    @IBOutlet weak var recentContainer: UIView!
    @IBOutlet weak var settingContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.layer.borderColor = UIColor.whiteColor().CGColor
        userImage.layer.cornerRadius = userImage.bounds.width / 2.0
        userImage.layer.masksToBounds = true
        userImage.layer.borderWidth = 1.5
        userImage.image = UIImage(named: "2")
        
        UIView.animateWithDuration(0.5, animations: {
            
            self.recentContainer.alpha = 0
            self.settingContainer.alpha = 1
        })
    }
    
    @IBAction func tabSelecting(sender: AnyObject) {
        
        if sender.selectedSegmentIndex == 0 {
            UIView.animateWithDuration(0.5, animations: {
                
                self.recentContainer.alpha = 0
                self.settingContainer.alpha = 1
            })
        } else {
            UIView.animateWithDuration(0.5, animations: {
                
                self.recentContainer.alpha = 1
                self.settingContainer.alpha = 0
            })
        }
    }

    @IBAction func back(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true) { 
            
        }
    }
}
