//
//  ItemStore.swift
//  HomepwnerThird
//
//  Created by yangpc on 2017. 7. 17..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class ItemStore {
    
    internal var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItemAtIndex(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let movedItem = allItems[fromIndex]
        
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem, at: toIndex)
    }
}
