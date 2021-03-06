//
//  ViewController.swift
//  Choone
//
//  Created by Mehrshad Jalilmasir on 9/23/16.
//  Copyright © 2016 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class BizProfileController: UIViewController , UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    
    
    let offset_HeaderStop:CGFloat = 60.0 // At this offset the Header stops its transformations
    let distance_W_LabelHeader:CGFloat = 20.0 // The distance between the top of the screen and the top of the White Label
    
    
    enum contentTypes {
        case tweets, media
    }
    // MARK: Outlet properties
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var headerView : UIView!
    @IBOutlet var segmentedView : UIView!
    @IBOutlet var headerLabel : UILabel!
    
    // MARK: class properties
    var headerBlurImageView:UIImageView!
    var headerImageView:UIImageView!
    var contentToDisplay : contentTypes = .tweets
    
    // MARK: The view
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.contentInset = UIEdgeInsetsMake(headerView.frame.height, 0, 0, 0)
        
        // Header - Image
        
        headerImageView = UIImageView(frame: headerView.bounds)
        headerImageView?.image = UIImage(named: "2")
        headerImageView?.contentMode = UIViewContentMode.scaleAspectFill
        headerView.insertSubview(headerImageView, belowSubview: headerLabel)
        
        // Header - Blurred Image
        headerBlurImageView = UIImageView(frame: headerView.bounds)
        headerBlurImageView?.image = UIImage(named: "2")?.blurredImage(withRadius: 10, iterations: 20, tintColor: UIColor.clear)
        headerBlurImageView?.contentMode = UIViewContentMode.scaleAspectFill
        headerBlurImageView?.alpha = 0.0
        headerView.insertSubview(headerBlurImageView, belowSubview: headerLabel)
        
        headerView.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table view processing
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch contentToDisplay {
        case .tweets:
            return 40
            
        case .media:
            return 20
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        
        switch contentToDisplay {
        case .tweets:
            cell.textLabel?.text = "Tweet Tweet!"
            
        case .media:
            cell.textLabel?.text = "Piccies!"
            cell.imageView?.image = UIImage(named: "header_bg")
        }
        
        
        
        return cell
    }
    
    // MARK: Scroll view delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y// + headerView.bounds.height
        
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN -----------------
        
        if offset < 0 {
            
            let headerScaleFactor:CGFloat = -(offset) / headerView.bounds.height
            let headerSizevariation = ((headerView.bounds.height * (1.0 + headerScaleFactor)) - headerView.bounds.height)/2
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            
            // Hide views if scrolled super fast
            headerView.layer.zPosition = 0
            headerLabel.isHidden = true
            
        }
            
            // SCROLL UP/DOWN ------------
            
        else {
            
            // Header -----------
            
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            
        }
        
        // Apply Transformations
        headerView.layer.transform = headerTransform
        //avatarImage.layer.transform = avatarTransform
        
        // Segment control
        
        let segmentViewOffset = segmentedView.frame.height - offset
        
        var segmentTransform = CATransform3DIdentity
        
        // Scroll the segment view until its offset reaches the same offset at which the header stopped shrinking
        segmentTransform = CATransform3DTranslate(segmentTransform, 0, max(segmentViewOffset, -offset_HeaderStop), 0)
        
        segmentedView.layer.transform = segmentTransform
        
        
        // Set scroll view insets just underneath the segment control
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(segmentedView.frame.height, 0, 0, 0)
        
    }
    
    // MARK: Interface buttons
    
    @IBAction func selectContentType(_ sender: UISegmentedControl) {
        
        // crap code I know
        if sender.selectedSegmentIndex == 0 {
            contentToDisplay = .tweets
        }
        else {
            contentToDisplay = .media
        }
        
        tableView.reloadData()
    }
}

