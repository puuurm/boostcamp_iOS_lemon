//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by yangpc on 2017. 7. 15..
//  Copyright © 2017년 yangpc. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    internal var itemStore: ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        
    }
    /* 
     Bronze Challenge of Chapter 9: Multi Section
     */
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Asks the data source to return the number of sections in the table view.
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Asks the data source for a cell to insert in a particular location of the table view.
        // Section 0: Over 50 dollar, Section 1: The Others
        var overFiftyDollar = 0
        for item in itemStore.allItems {
            if item.valueInDollars > 50 {
                overFiftyDollar += 1
            }
        }
        if section == 0 {
            return overFiftyDollar
        } else {
            return itemStore.allItems.count - overFiftyDollar
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Asks the data source for the title of the header of the specified section of the table view.
        if section == 0 {
            return "Over 50 Dollars"
        } else {
            return "The Others"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Asks the data source for a cell to insert in a particular location of the table view.
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")

        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        // let row = indexPath.row
        let section = indexPath.section
        let row = indexPath.row
        
        var item = itemStore.allItems[row] // 일단 현재 row 인덱스에 있는 item 값으로 초기화
        var numberOfPutItem = 0
        
        for i in itemStore.allItems {
            if ( section == 0 && i.valueInDollars > 50 ) || ( section == 1 &&  i.valueInDollars <= 50 ) {
                // put item in cell
                numberOfPutItem += 1
            }
            if numberOfPutItem == row + 1 {
                // Section 당 현재 셀의 갯수와 셀에 넣은 아이템 갯수가 같은 경우, 셀에 아이탬을 넣어준다.
                item = i
                break
            }
        }
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
}
