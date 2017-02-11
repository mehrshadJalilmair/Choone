//
//  HomeController.swift
//  Choone
//
//  Created by Mehrshad Jalilmasir on 9/23/16.
//  Copyright © 2016 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class HomeController: UIViewController{
    
    @IBOutlet weak var _tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(reachabilityStatus)
        
        let rule:PublicRule = PublicRule(id: "1",name: "bia", explain: "khoobe", howMuch: "50", from: "100", type: "0")
        
        nearbyBizes.append(Biz(id: "1", name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule , rule , rule , rule ,rule , rule , rule , rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
        nearbyBizes.append(Biz(id: "2",name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
        nearbyBizes.append(Biz(id: "3",name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
        nearbyBizes.append(Biz(id: "4",name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
        nearbyBizes.append(Biz(id: "5",name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
        nearbyBizes.append(Biz(id: "6",name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
        
        _tableView.separatorStyle = .None
        
        configureNavigationBar()
        configureStatusBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBar.translucent = false
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return nearbyBizes.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("BizCell", forIndexPath: indexPath) as! BizCell
        
        cell.biz = nearbyBizes[indexPath.row]
        
        cell.selectionStyle = .None
        
        let hexString = colorsArray[indexPath.row]
        let color = UIColor.colorFromHexString(hexString)
        
        cell.background.backgroundColor = color
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        selectedBizIndex = indexPath.row
        from = 1
        self.performSegueWithIdentifier("show biz" , sender: self)
    }
}

extension HomeController {
    
    private func configureNavigationBar() {
        
        //transparent background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.tintColor = .whiteColor()
        
        if let font = UIFont(name: "Avenir-medium" , size: 18) {
            self.navigationController?.navigationBar.titleTextAttributes = [
                NSForegroundColorAttributeName : UIColor.whiteColor(),
                NSFontAttributeName : font
            ]
        }
        
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }
    
    private func configureStatusBar() {
        guard  let statusBar = UIApplication.sharedApplication().valueForKey("statusBarWindow")?.valueForKey("statusBar") as? UIView else {
            return
        }
        
        statusBar.backgroundColor = .clearColor()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
}


