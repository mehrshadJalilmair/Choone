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
        leftSwipe.direction = .right
        view.addGestureRecognizer(leftSwipe)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        waiting.hidesWhenStopped = true
        
        tableView.keyboardDismissMode = .onDrag
        
        searcbBar1.backgroundImage = UIImage()
        searchBar2.backgroundImage = UIImage()
        
        let searchTextField1: UITextField? = searcbBar1.value(forKey: "searchField") as? UITextField
        if searchTextField1!.responds(to: #selector(getter: UITextField.attributedPlaceholder)) {
            //var color = UIColor.purpleColor()
            let attributeDict = [NSForegroundColorAttributeName: UIColor.lightGray.withAlphaComponent(0.5)]
            searchTextField1!.attributedPlaceholder = NSAttributedString(string: "فروشگاه اینترنتی،رستوران،پوشاک...", attributes: attributeDict)
        }
        searchTextField1?.textAlignment = .right
        
        let searchTextField2: UITextField? = searchBar2.value(forKey: "searchField") as? UITextField
        if searchTextField2!.responds(to: #selector(getter: UITextField.attributedPlaceholder)) {
            //var color = UIColor.purpleColor()
            let attributeDict = [NSForegroundColorAttributeName: UIColor.lightGray.withAlphaComponent(0.5)]
            searchTextField2!.attributedPlaceholder = NSAttributedString(string: "خیابان آزادی،تهران،اصفهان...", attributes: attributeDict)
        }
        searchTextField2?.textAlignment = .right
        
        //self.navigationController?.navigationBarHidden = true
        tableView.separatorStyle = .none
        
        if let font = UIFont(name: "B Yekan", size: 15) {
            
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName :font , NSForegroundColorAttributeName: UIColor.white]
        }
    }
    
    func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        
        if (sender.direction == .right) {
            
            //self.navigationController?.popToRootViewController(animated: true)//back to previous
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
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
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return searchResults.count
    }
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BizCell", for: indexPath) as! BizCell
        
        cell.biz = searchResults[indexPath.row]
        
        cell.selectionStyle = .none
        
        let hexString = colorsArray[indexPath.row]
        let color = UIColor.colorFromHexString(hexString)
        
        cell.background.backgroundColor = color
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath)
    {
        selectedBizIndex = indexPath.row
        from = 0
        self.performSegue(withIdentifier: "show biz" , sender: indexPath.row)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
    }
    
    @IBAction func back(_ sender: AnyObject) {
        
        //self.navigationController?.popToRootViewControllerAnimated(true)//back to previous
        self.dismiss(animated: true) { 
            
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
}
