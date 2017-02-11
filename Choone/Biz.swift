//
//  Biz.swift
//  Choone
//
//  Created by Mehrshad Jalilmasir on 9/24/16.
//  Copyright © 2016 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class Biz
{
    internal var id = String()
    internal var Name = String()
    internal var Address = String()
    internal var p_rules:[PublicRule] = [PublicRule]()
    internal var lat = 0.0
    internal var long = 0.0
    internal var imageAddress = String()
    
    init(id:String , name:String , address:String , p_rules:[PublicRule] , lat:Double , long:Double , imageURL:String)
    {
        self.id = id
        Name = name
        Address = address
        self.p_rules = p_rules
        self.lat = lat
        self.long = long
        self.imageAddress = imageURL
    }
}
