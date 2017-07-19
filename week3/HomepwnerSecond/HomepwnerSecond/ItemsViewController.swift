//
//  ItemsViewController.swift
//  HomepwnerSecond
//
//  Created by yangpc on 2017. 7. 16..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//
/* -----------------------------------------------------------------
 [Chapter 10 ]
 Bronze Challenge: Rename Delete Button
 -> 버튼의 이름을 Remove로 바꾸기
 
 Silver & Gold Challenge: Preventing Reording
 -> 마지막 행에 "No more items!" 추가
 -> 마지막 행을 움직일 수 없도록 만든다.
 -> 마지막 행을 삭제할 수 없도록 만든다.
 -> 다른 행에서 마지막 행으로 이동할 수 없게 만든다. 즉 마지막 행은 마지막 위치에서 벗어나지 않도록 한다.
 --------------------------------------------------------------------- */
import UIKit

class ItemsViewController: UITableViewController {
    
    internal var itemStore: ItemStore!
    
    // MARK: Action
    
    @IBAction func addNewItem(_ sender: UIButton) {
        let newItem = itemStore.createItem()
        
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if isEditing {
            // UIViewController has editing property
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
    }
    // add last cell for "No more items!"
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        
        if indexPath.row == itemStore.allItems.count {
            cell.textLabel?.text = "No more items!"
            cell.detailTextLabel?.text = ""
        } else {
            let item = itemStore.allItems[indexPath.row]
            
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        }
        
        
        return cell
    }
    
    /* Delete row */
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancleAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancleAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
            self.itemStore.removeItem(item: item)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            
            ac.addAction(deleteAction)
            
            present(ac, animated: true, completion: nil)
        }
    }
    
    /* Move row */
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItemAtIndex(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    /* Cannot move last cell */
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != itemStore.allItems.count
    }
    
    /* Cannot delete last cell */
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != itemStore.allItems.count
    }
    
    /*
     Bronze Challenge of Chapter 10: Rename the Delete Button
     */
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
    /* Maintain position of last cell, cannot move from other cell to the last cell */
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.row == itemStore.allItems.count {
            return sourceIndexPath
        } else {
            return proposedDestinationIndexPath
        }
    }
    /*
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "No more Items!"
    }
    */
}
