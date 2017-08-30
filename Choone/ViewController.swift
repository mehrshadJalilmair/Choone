//
//  ViewController.swift
//  Twitter User Interface
//
//  Created by Dean Brindley on 25/04/2015.
//  Copyright (c) 2015 Dean Brindley. All rights reserved.
//

import UIKit
import FoldingCell

enum Paging {
    case home, cards, search
}
var selectedBizIndex:Int!
var from:Int!

let offset_HeaderStop:CGFloat = 40.0 // At this offset the Header stops its transformations
let distance_W_LabelHeader:CGFloat = 30.0 // The distance between the top of the screen and the top of the White Label

enum contentTypes {
    case rewards, activity, details
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate , rewarding {

    let kCloseCellHeight: CGFloat = 85
    let kOpenCellHeight: CGFloat = 125
    var cellHeights = [CGFloat]()
    
    // MARK: Outlet properties
    @IBOutlet var tableView : UITableView!
    @IBOutlet var headerView : UIView!
    @IBOutlet var profileView : UIView!
    @IBOutlet var segmentedView : UIView!
    @IBOutlet var avatarImage:UIImageView!
    @IBOutlet var handleLabel : UILabel!
    @IBOutlet var headerLabel : UILabel!
    @IBOutlet var back : UIButton!
    
    // MARK: class properties
    var headerBlurImageView:UIImageView!
    var headerImageView:UIImageView!
    var contentToDisplay : contentTypes = .rewards
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createCellHeightsArray()
        tableView.contentInset = UIEdgeInsetsMake(headerView.frame.height, 0, 0, 0)
        tableView.separatorStyle = .none
    }
    
    // MARK: configure
    func createCellHeightsArray() {

        if from == 0 {
            
            for _ in 0...searchResults[selectedBizIndex].p_rules.count {
                cellHeights.append(kCloseCellHeight)
            }
        }else if from == 1 {
            
            for _ in 0...nearbyBizes[selectedBizIndex].p_rules.count {
                cellHeights.append(kCloseCellHeight)
            }
        }else if from == 2 {
            
            for _ in 0...cards[selectedBizIndex].p_rules.count {
                cellHeights.append(kCloseCellHeight)
            }
        }
        else if from == 3 {
            
            for _ in 0...ChangedSearchResults[selectedBizIndex].p_rules.count {
                cellHeights.append(kCloseCellHeight)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var url = ""
        
        if from == 0 {
            
            url = searchResults[selectedBizIndex].imageAddress
        }else if from == 1 {
            
            url = nearbyBizes[selectedBizIndex].imageAddress
        }else if from == 2 {
            
            url = cards[selectedBizIndex].imageAddress
        }
        else if from == 3
        {
            url = ChangedSearchResults[selectedBizIndex].imageAddress
        }

        
        headerImageView = UIImageView(frame: headerView.bounds)
        headerImageView?.image = UIImage(named: url)
        headerImageView?.contentMode = UIViewContentMode.scaleAspectFill
        headerView.insertSubview(headerImageView, belowSubview: headerLabel)
        
        // Header - Blurred Image
        headerBlurImageView = UIImageView(frame: headerView.bounds)
        headerBlurImageView?.image = UIImage(named: url)?.blurredImage(withRadius: 10, iterations: 20, tintColor: UIColor.clear)
        headerBlurImageView?.contentMode = UIViewContentMode.scaleAspectFill
        headerBlurImageView?.alpha = 0.0
        headerView.insertSubview(headerBlurImageView, belowSubview: headerLabel)
        
        /*back = UIButton(frame: CGRect(x: 15, y: 30, width: 20, height: 20))
        back.setImage(UIImage(named: "universal_back"), forState: UIControlState.Normal)
        headerView.insertSubview(back, belowSubview: headerLabel)*/
        
        headerView.clipsToBounds = true
        
        avatarImage.image = UIImage(named: url)
    }


    // MARK: Table view processing
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeights[indexPath.row]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch contentToDisplay {
        case .rewards:

            if from == 0 {
                
                return searchResults[selectedBizIndex].p_rules.count
            }else if from == 1 {
                
                return nearbyBizes[selectedBizIndex].p_rules.count
            }else if from == 2 {
                
                return cards[selectedBizIndex].p_rules.count
            }
            else if from == 3
            {
                return ChangedSearchResults[selectedBizIndex].p_rules.count
            }
            
        case .activity:
            return 0
            
        case .details:
            return 0
            
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCell" , for: indexPath) as! RewardCell
        if from == 0 {
            
            cell.rule = searchResults[selectedBizIndex].p_rules[indexPath.row]
        }else if from == 1 {
            
            cell.rule = nearbyBizes[selectedBizIndex].p_rules[indexPath.row]
        }else if from == 2 {
            
            cell.rule = cards[selectedBizIndex].p_rules[indexPath.row]
        }else if from == 3 {
            
            cell.rule = ChangedSearchResults[selectedBizIndex].p_rules[indexPath.row]
        }
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell is FoldingCell {
            let foldingCell = cell as! FoldingCell
            
            if cellHeights[indexPath.row] == kCloseCellHeight {
                foldingCell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                foldingCell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 1.1
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)
    }
    
    
    // MARK: Scroll view delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y + headerView.bounds.height
        
        var avatarTransform = CATransform3DIdentity
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
            
            //  ------------ Label
            
            headerLabel.isHidden = false
            let alignToNameLabel = -offset + handleLabel.frame.origin.y + headerView.frame.height + offset_HeaderStop
            
            headerLabel.frame.origin = CGPoint(x: headerLabel.frame.origin.x, y: max(alignToNameLabel, distance_W_LabelHeader + offset_HeaderStop))
            
            
            //  ------------ Blur
            
            headerBlurImageView?.alpha = min (1.0, (offset - alignToNameLabel)/distance_W_LabelHeader)
            
            // Avatar -----------
            
            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / avatarImage.bounds.height / 1.4 // Slow down the animation
            let avatarSizeVariation = ((avatarImage.bounds.height * (1.0 + avatarScaleFactor)) - avatarImage.bounds.height) / 2.0
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            
            if offset <= offset_HeaderStop {
                
                if avatarImage.layer.zPosition < headerView.layer.zPosition{
                    headerView.layer.zPosition = 0
                }
                
                
            }else {
                if avatarImage.layer.zPosition >= headerView.layer.zPosition{
                    headerView.layer.zPosition = 2
                }
                
            }
            
        }
        
        // Apply Transformations
        headerView.layer.transform = headerTransform
        avatarImage.layer.transform = avatarTransform
        
        // Segment control
        
        let segmentViewOffset = profileView.frame.height - segmentedView.frame.height - offset
        
        var segmentTransform = CATransform3DIdentity
        
        // Scroll the segment view until its offset reaches the same offset at which the header stopped shrinking
        segmentTransform = CATransform3DTranslate(segmentTransform, 0, max(segmentViewOffset, -offset_HeaderStop), 0)
        
        segmentedView.layer.transform = segmentTransform
        
        
        // Set scroll view insets just underneath the segment control
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(segmentedView.frame.maxY, 0, 0, 0)
    }
    
    // MARK: Interface buttons
    @IBAction func selectContentType(_ sender: UISegmentedControl) {
        
        // crap code I know
        if sender.selectedSegmentIndex == 0 {
            contentToDisplay = .rewards
        }
        else if sender.selectedSegmentIndex == 1{
            contentToDisplay = .activity
        }
        else{
            contentToDisplay = .details
        }
        
        tableView.reloadData()
    }
    
    @IBAction func follow() {
        
    }
    
    @IBAction func back(_ sender: AnyObject) {
        
        self.dismiss(animated: true) { 
            
        }
    }
    
    func getReward(_ cell: RewardCell) {
        
        print("get points")
    }
    func useReward(_ cell: RewardCell) {
        
        print("use points")
    }
}

