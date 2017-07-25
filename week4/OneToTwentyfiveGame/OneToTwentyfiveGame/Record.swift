//
//  Record.swift
//  OneToTwentyfiveGame
//
//  Created by yangpc on 2017. 7. 24..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class Record: NSObject, NSCoding {
    var name: String
    var startDate: Date
    var clearTime: String
    
    init(name: String, clearTime: String) {
        self.name = name
        self.startDate = Date()
        self.clearTime = clearTime
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(startDate, forKey: "startDate")
        aCoder.encode(clearTime, forKey: "clearTime")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        startDate = aDecoder.decodeObject(forKey: "startDate") as! Date
        clearTime = aDecoder.decodeObject(forKey: "clearTime") as! String
        
        super.init()
    }
}
