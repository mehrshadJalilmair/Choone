//
//  CardsController.swift
//  Choone
//
//  Created by Mehrshad Jalilmasir on 9/23/16.
//  Copyright © 2016 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class CardsController: UIViewController {
    
    let kCellHeight: CGFloat = 148.0
    let kItemSpace: CGFloat = -20
    let kDemoCell = "CardCell"
    
    override func viewDidLoad() {
        
        configureNavigationBar()
        configureStatusBar()
        
        let rule:PublicRule = PublicRule(id: "1",name: "bia", explain: "khoobe", howMuch: "50", from: "100", type: "0")
        cards.append(Biz(id: "1", name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
        cards.append(Biz(id: "2",name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
        cards.append(Biz(id: "3",name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
        cards.append(Biz(id: "4",name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
        cards.append(Biz(id: "5",name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
        cards.append(Biz(id: "6",name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
    }
}

extension CardsController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kDemoCell, forIndexPath: indexPath) as! CornerCollectionViewCell
        
        let hexString = colorsArray[indexPath.row]
        let color = UIColor.colorFromHexString(hexString)
        cell.color = color
        
        let biz = cards[indexPath.row]
        
        cell.biz = biz
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        selectedBizIndex = indexPath.row
        from = 2
        performSegueWithIdentifier("show biz", sender: indexPath.row)
    }
}

extension CardsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(CGRectGetWidth(view.bounds), kCellHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: NSInteger) -> CGFloat {
        return kItemSpace
    }
}

extension CardsController {
    
    private func configureNavigationBar() {
        
        //transparent background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = false
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

