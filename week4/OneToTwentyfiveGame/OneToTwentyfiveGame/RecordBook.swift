//
//  RecordBook.swift
//  OneToTwentyfiveGame
//
//  Created by yangpc on 2017. 7. 24..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class RecordBook {
    var allRecords = [Record]() {
        didSet {
            allRecords.sort { $0.clearTime < $1.clearTime }
        }
    }
    @discardableResult func createRecord(name: String, clearTiem: String) -> Record {
        let newRecord = Record(name: name, clearTime: clearTiem)
        allRecords.append(newRecord)
        return newRecord
    }
    
    func removeRecord(record: Record) {
        if let index = allRecords.index(of: record) {
            allRecords.remove(at: index)
        }
    }
    
    func updateRecord() -> String{
        if !allRecords.isEmpty {
            return allRecords[0].name + " " + allRecords[0].clearTime
        }
        return "- --:--:--"
        
    }
}
