//
//  Rules.swift
//  Choone
//
//  Created by Mehrshad Jalilmasir on 9/24/16.
//  Copyright © 2016 Mehrshad Jalilmasir. All rights reserved.
//

import UIKit

class PublicRule {
    
    internal var id = String()
    internal var name = String()
    internal var explain = String()
    internal var howMuch = String()
    internal var from = String()
    internal var type = String()//1,2,3,4
    
    init(id:String ,name:String , explain :String , howMuch:String , from:String , type:String)
    {
        self.id = id
        self.name = name
        self.explain = explain
        self.howMuch = howMuch
        self.from = from
        self.type = type
    }
}

