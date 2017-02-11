//
//  SearchController.swift
//  Choone
//
//  Created by Mehrshad Jalilmasir on 9/23/16.
//  Copyright © 2016 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class SearchController: UIViewController , UISearchBarDelegate{

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureStatusBar()
        
        if let font = UIFont(name: "B Yekan", size: 15) {
            
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName :font , NSForegroundColorAttributeName: UIColor.whiteColor()]
        }
        //self.searchBar.layer.borderColor = UIColor.blueColor().CGColor
        //self.searchBar.layer.borderWidth = 1
        //self.searchBar.layer.cornerRadius = 3.0
        //self.searchBar.clipsToBounds = true
        //self.searchBar.barTintColor = UIColor.blueColor()
        //self.searchBar.setImage(UIImage(named: "placeholder.png"), forSearchBarIcon: UISearchBarIcon.Search, state: UIControlState.Normal)
        self.searchBar.layer.cornerRadius = 8.0
        self.searchBar.layer.masksToBounds = true
        
        let searchTextField: UITextField? = searchBar.valueForKey("searchField") as? UITextField
        if searchTextField!.respondsToSelector(Selector("attributedPlaceholder")) {
            //var color = UIColor.purpleColor()
            let attributeDict = [NSForegroundColorAttributeName: UIColor.lightGrayColor().colorWithAlphaComponent(0.5)]
            searchTextField!.attributedPlaceholder = NSAttributedString(string: "به دنبال چه چیزی هستی؟", attributes: attributeDict)
        }
        searchTextField?.textAlignment = .Right
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        self.searchBar.endEditing(true)
        //print("here here")
    }
    
    //Mark : search bar Impls and methods
    func searchBarTextDidBeginEditing(searchBar: UISearchBar)
    {
        print("searchBarTextDidBeginEditing")
        /*self.dismissViewControllerAnimated(true, completion: {})
         let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let vc = storyboard.instantiateViewControllerWithIdentifier("KojaSearch")
         presentViewController(vc, animated: true, completion:nil)*/
        performSegueWithIdentifier("WhatWhereSearch", sender: searchBar)
    }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
        self.view.endEditing(true)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
        print("touchesBegan")
    }
}

extension SearchController {
    
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

