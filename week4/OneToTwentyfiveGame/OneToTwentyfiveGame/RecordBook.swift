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
    let recordArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory , in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("records.archive")
        
    }()
    
    init() {
        if let archivedRecords = NSKeyedUnarchiver.unarchiveObject(withFile: recordArchiveURL.path) as? [Record] {
            allRecords = archivedRecords
        }
    }
    @discardableResult func createRecord(name: String, clearTiem: String) -> Record {
        let newRecord = Record(name: name, clearTime: clearTiem)
        allRecords.append(newRecord)
        //self.saveChanges()
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
    
    func saveChanges() -> Bool {
        print("Saving items to: \(recordArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allRecords, toFile: recordArchiveURL.path)
    }
}
