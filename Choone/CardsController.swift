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
        
        //configureNavigationBar()
        //configureStatusBar()
        
        let rule1:PublicRule = PublicRule(id: "1",name: "65 min,223 Calories", explain: "2/2/2017", howMuch: "50", from: "100", type: "0")
        
        cards.append(Biz(id: "1", name: "lyon recreation center" , address: "25 pts" , p_rules: [rule1] , lat: 0.0 , long: 0.0 , imageURL: "1w"))
    }
}

extension CardsController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kDemoCell, for: indexPath) as! CornerCollectionViewCell
        
        let hexString = colorsArray[indexPath.row]
        let color = UIColor.colorFromHexString(hexString)
        cell.color = color
        
        let biz = cards[indexPath.row]
        
        cell.biz = biz
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedBizIndex = indexPath.row
        from = 2
        performSegue(withIdentifier: "show biz", sender: indexPath.row)
    }
}

extension CardsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: kCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: NSInteger) -> CGFloat {
        return kItemSpace
    }
}

extension CardsController {
    
    fileprivate func configureNavigationBar() {
        
        //transparent background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .white
        
        if let font = UIFont(name: "Avenir-medium" , size: 18) {
            self.navigationController?.navigationBar.titleTextAttributes = [
                NSForegroundColorAttributeName : UIColor.white,
                NSFontAttributeName : font
            ]
        }
        
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }
    
    fileprivate func configureStatusBar() {
        guard  let statusBar = (UIApplication.shared.value(forKey: "statusBarWindow") as AnyObject).value(forKey: "statusBar") as? UIView else {
            return
        }
        
        statusBar.backgroundColor = .clear
        UIApplication.shared.statusBarStyle = .lightContent
    }
}

