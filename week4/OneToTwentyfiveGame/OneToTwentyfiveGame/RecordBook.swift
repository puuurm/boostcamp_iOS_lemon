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
    
    @discardableResult func createRecord(name: String, startDate: Date, clearTiem: String) -> Record {
        let newRecord = Record(name: name, startDate: startDate, clearTime: clearTiem)
        allRecords.append(newRecord)
        return newRecord
    }
}
