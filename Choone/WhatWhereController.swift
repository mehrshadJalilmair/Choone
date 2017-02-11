//
//  WhatWhereController.swift
//  Choone
//
//  Created by Mehrshad Jalilmasir on 9/24/16.
//  Copyright © 2016 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class WhatWhereController: UIViewController , UISearchBarDelegate , UITextFieldDelegate{

    
    @IBOutlet weak var searcbBar1: UISearchBar!
    @IBOutlet weak var searchBar2: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var waiting: UIActivityIndicatorView!
    
    @IBOutlet weak var result: UILabel!
    
    var what:String = ""
    var _where:String = ""
    
    override func viewWillLayoutSubviews() {
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(WhatWhereController.handleSwipes(_:)))
        leftSwipe.direction = .Right
        view.addGestureRecognizer(leftSwipe)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        waiting.hidesWhenStopped = true
        
        tableView.keyboardDismissMode = .OnDrag
        
        searcbBar1.backgroundImage = UIImage()
        searchBar2.backgroundImage = UIImage()
        
        let searchTextField1: UITextField? = searcbBar1.valueForKey("searchField") as? UITextField
        if searchTextField1!.respondsToSelector(Selector("attributedPlaceholder")) {
            //var color = UIColor.purpleColor()
            let attributeDict = [NSForegroundColorAttributeName: UIColor.lightGrayColor().colorWithAlphaComponent(0.5)]
            searchTextField1!.attributedPlaceholder = NSAttributedString(string: "فروشگاه اینترنتی،رستوران،پوشاک...", attributes: attributeDict)
        }
        searchTextField1?.textAlignment = .Right
        
        let searchTextField2: UITextField? = searchBar2.valueForKey("searchField") as? UITextField
        if searchTextField2!.respondsToSelector(Selector("attributedPlaceholder")) {
            //var color = UIColor.purpleColor()
            let attributeDict = [NSForegroundColorAttributeName: UIColor.lightGrayColor().colorWithAlphaComponent(0.5)]
            searchTextField2!.attributedPlaceholder = NSAttributedString(string: "خیابان آزادی،تهران،اصفهان...", attributes: attributeDict)
        }
        searchTextField2?.textAlignment = .Right
        
        //self.navigationController?.navigationBarHidden = true
        tableView.separatorStyle = .None
        
        if let font = UIFont(name: "B Yekan", size: 15) {
            
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName :font , NSForegroundColorAttributeName: UIColor.whiteColor()]
        }
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        
        if (sender.direction == .Right) {
            
            self.navigationController?.popToRootViewControllerAnimated(true)//back to previous
        }
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        self.view.endEditing(true)
    }
    func hideKeyboard()
    {
        tableView.endEditing(true)
    }
    func reachabilityStatusChanged()
    {
        if reachabilityStatus == KNOTREACHABLE {
            
            
        }
        else if reachabilityStatus == KREACHABLEWITHWWAN {
            
            
        }
        else if reachabilityStatus == KREACHABLEWITHWIFI {
            
            
        }
        print("\(reachabilityStatus)")
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar == searcbBar1 {
            
            what = searchText
        }
        else
        {
            _where = searchText
        }
        
        if (NSString(string:what).length >= 0 && NSString(string:what).length < 3) && (NSString(string:_where).length < 3 && NSString(string:what).length >= 0)
        {
            return
        }
        
        self.updateTable()
    }
    func updateTable()
    {
        print("\(what) \(_where)")
        let rule:PublicRule = PublicRule(id: "1",name: "bia", explain: "khoobe", howMuch: "50", from: "100", type: "0")
        searchResults.append(Biz(id: "1", name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
        searchResults.append(Biz(id: "2",name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
        searchResults.append(Biz(id: "3",name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
        searchResults.append(Biz(id: "4",name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
        searchResults.append(Biz(id: "5",name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
        searchResults.append(Biz(id: "6",name: "اسم" , address: " آدرس آدرس آدرس آدرس آدرس آدرس" , p_rules: [rule] , lat: 0.0 , long: 0.0 , imageURL: ""))
        
        tableView.reloadData()
    }
    
    //MARK : Table View Impls
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return searchResults.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("BizCell", forIndexPath: indexPath) as! BizCell
        
        cell.biz = searchResults[indexPath.row]
        
        cell.selectionStyle = .None
        
        let hexString = colorsArray[indexPath.row]
        let color = UIColor.colorFromHexString(hexString)
        
        cell.background.backgroundColor = color
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        selectedBizIndex = indexPath.row
        from = 0
        self.performSegueWithIdentifier("show biz" , sender: indexPath.row)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
    }
    
    @IBAction func back(sender: AnyObject) {
        
        //self.navigationController?.popToRootViewControllerAnimated(true)//back to previous
        self.dismissViewControllerAnimated(true) { 
            
            
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
}
