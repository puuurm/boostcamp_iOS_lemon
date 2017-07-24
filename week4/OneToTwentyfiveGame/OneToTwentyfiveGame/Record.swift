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
    var startTime: Date
    var clearTime: Date
    
    init(name: String, startTime: Date, clearTime: Date) {
        self.name = name
        self.startTime = startTime
        self.clearTime = clearTime
        super.init()
    }
}
