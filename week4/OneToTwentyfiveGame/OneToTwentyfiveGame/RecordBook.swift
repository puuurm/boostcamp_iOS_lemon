//
//  RecordBook.swift
//  OneToTwentyfiveGame
//
//  Created by yangpc on 2017. 7. 24..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class RecordBook {
    var allRecords = [Record]()
    
    func createRecord(record: Record) {
        allRecords.append(record)
    }
}
