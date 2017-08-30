//
//  SearchController.swift
//  Choone
//
//  Created by Mehrshad Jalilmasir on 9/23/16.
//  Copyright © 2016 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class SearchController: UIViewController , UISearchBarDelegate{

    @IBOutlet weak var _tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configureNavigationBar()
        //configureStatusBar()
        
        if let font = UIFont(name: "B Yekan", size: 15) {
            
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName :font , NSForegroundColorAttributeName: UIColor.white]
        }

        let rule1:PublicRule = PublicRule(id: "1",name: "", explain: "", howMuch: "50", from: "100", type: "0")
        
        ChangedSearchResults.append(Biz(id: "1", name: "5% off for USC football games tickets" , address: "" , p_rules: [rule1] , lat: 0.0 , long: 0.0 , imageURL: "5w"))
        
        _tableView.separatorStyle = .none
    }
    
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return ChangedSearchResults.count
    }
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BizCell", for: indexPath) as! BizCell
        
        cell.biz = ChangedSearchResults[indexPath.row]
        
        cell.selectionStyle = .none
        
        let hexString = colorsArray[indexPath.row]
        let color = UIColor.colorFromHexString(hexString)
        
        cell.background.backgroundColor = color
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath)
    {
        selectedBizIndex = indexPath.row
        from = 3
        self.performSegue(withIdentifier: "show biz" , sender: self)
    }

}

extension SearchController {
    
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

