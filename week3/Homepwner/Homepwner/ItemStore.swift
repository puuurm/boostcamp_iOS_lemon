//
//  ItemStore.swift
//  Homepwner
//
//  Created by yangpc on 2017. 7. 15..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class ItemStore {
    
    internal var allItems = [Item]()
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
}
