//
//  Record.swift
//  OneToTwentyfiveGame
//
//  Created by yangpc on 2017. 7. 24..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class Record: NSObject {
    var name: String
    var startDate: Date
    var clearTime: String
    
    init(name: String, clearTime: String) {
        self.name = name
        self.startDate = Date()
        self.clearTime = clearTime
        super.init()
    }
}
