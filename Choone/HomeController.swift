//
//  HomeController.swift
//  Choone
//
//  Created by Mehrshad Jalilmasir on 9/23/16.
//  Copyright © 2016 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var _tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let font = UIFont(name: "B Yekan", size: 15) {
            
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName :font , NSForegroundColorAttributeName: UIColor.white]
        }

        self.searchBar.layer.cornerRadius = 8.0
        self.searchBar.layer.masksToBounds = true
        
        let searchTextField: UITextField? = searchBar.value(forKey: "searchField") as? UITextField
        if searchTextField!.responds(to: #selector(getter: UITextField.attributedPlaceholder)) {
            //var color = UIColor.purpleColor()
            let attributeDict = [NSForegroundColorAttributeName: UIColor.lightGray.withAlphaComponent(0.5)]
            searchTextField!.attributedPlaceholder = NSAttributedString(string: "", attributes: attributeDict)
        }
        searchTextField?.textAlignment = .right
        
        print(reachabilityStatus)
        
        let rule1:PublicRule = PublicRule(id: "1",name: "1 hour", explain: "10 pts, 200 Calories: 15 pts", howMuch: "50", from: "100", type: "0")
        let rule2:PublicRule = PublicRule(id: "1",name: "10% off for each purchase", explain: "", howMuch: "50", from: "100", type: "0")
        let rule3:PublicRule = PublicRule(id: "1",name: "5 pts", explain: "", howMuch: "50", from: "100", type: "0")
        let rule4:PublicRule = PublicRule(id: "1",name: "15% off for each purchase", explain: "", howMuch: "50", from: "100", type: "0")
        
        nearbyBizes.append(Biz(id: "1", name: "lyon recreation center" , address: " 125 pts" , p_rules: [rule1] , lat: 0.0 , long: 0.0 , imageURL: "1w"))
        nearbyBizes.append(Biz(id: "2",name: "USC bookstore" , address: " 10 $" , p_rules: [rule2] , lat: 0.0 , long: 0.0 , imageURL: "2w"))
        nearbyBizes.append(Biz(id: "3",name: "T.A. office hours (CS 560)" , address: " 20 pts" , p_rules: [rule3] , lat: 0.0 , long: 0.0 , imageURL: "3w"))
        nearbyBizes.append(Biz(id: "4",name: "California Pizza Kitchen" , address: "7 $" , p_rules: [rule4] , lat: 0.0 , long: 0.0 , imageURL: "4w"))
        
        _tableView.separatorStyle = .none
        
        //configureNavigationBar()
        //configureStatusBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return nearbyBizes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BizCell", for: indexPath) as! BizCell
        
        cell.biz = nearbyBizes[indexPath.row]
        
        cell.selectionStyle = .none
        
        let hexString = colorsArray[indexPath.row]
        let color = UIColor.colorFromHexString(hexString)
        
        cell.background.backgroundColor = color
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath)
    {
        selectedBizIndex = indexPath.row
        from = 1
        self.performSegue(withIdentifier: "show biz" , sender: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.searchBar.endEditing(true)
        //print("here here")
    }
    
    //Mark : search bar Impls and methods
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        print("searchBarTextDidBeginEditing")

        performSegue(withIdentifier: "WhatWhereSearch", sender: searchBar)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        print("touchesBegan")
    }
}

extension HomeController {
    
    fileprivate func configureNavigationBar() {
        
        //transparent background
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
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


