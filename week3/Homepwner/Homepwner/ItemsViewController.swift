//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by yangpc on 2017. 7. 15..
//  Copyright © 2017년 yangpc. All rights reserved.
//

/* -----------------------------------------------------------------
 [Chapter 9 ]
 Bronze Challenge: Multi Section
 -> 두개의 섹션 표시
 
 Silver Challenge: Constant Rows
 -> 마지막 행에 "No more items!" 출력
 
 Gold Challenge: Customizing the Table
 -> 마지막 행: 행의 높이(44), 나머지 행: 행의 높이(60) 폰트(20), 배경에 이미지 표시
 --------------------------------------------------------------------- */

import UIKit

class ItemsViewController: UITableViewController {
    
    internal var itemStore: ItemStore!
    private var overFiftyDollars = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        initView()
        countNumberOfItemsInSection()
        
    }
    private func initView() {
        let backgroundImage = UIImage(named: "backgroundImage")
        tableView.backgroundView = UIImageView(image: backgroundImage)
    }
    // 섹션에 분류되는 아이탬의 수를 구한다. -> 섹션 0: 50 달러 이상.
    private func countNumberOfItemsInSection() {
        for item in itemStore.allItems {
            if item.valueInDollars > 50 {
                overFiftyDollars += 1
            }
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Asks the data source to return the number of sections in the table view.
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Asks the data source for a cell to insert in a particular location of the table view.
        // Section 0: Over 50 dollar, Section 1: The Others
        // 각 섹션의 마지막 셀에 No more items! 를 출력한다.
        if section == 0 {
            return overFiftyDollars + 1
        } else {
            return itemStore.allItems.count - overFiftyDollars + 1
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 마지막 행의 높이만 44 포인트로 지정
        if ( indexPath.section == 0 && indexPath.row == overFiftyDollars) || (indexPath.section == 1 && indexPath.row == itemStore.allItems.count - overFiftyDollars) {
            return 44
        }
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Asks the data source for a cell to insert in a particular location of the table view.
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")

        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let section = indexPath.section
        let row = indexPath.row
        
        let sumOfRows = tableView.numberOfRows(inSection: section)
        
        /* 이 방법도 좋은 방법입니다만, 하단에 고정적인 내용을 보여주려면 더 좋은 방법은 없을까요? (꼭 row를 추가해야 한다고 생각할 필요는 없습니다) */
        // 현재 섹션의 총 행의 개수 (해당 섹션 아이탬 수 + 마지막 문구 한 개)와 현재 행의 인덱스 + 1 이 같다면, 그것은 마지막 행이다.
        if ( row + 1 == sumOfRows ) {
            cell.textLabel?.text = "No more items!"
            cell.detailTextLabel?.text = ""
        } else {
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
            cell.textLabel?.font = cell.textLabel?.font.withSize(20) // 마지막 행 제외한 나머지 행 폰트 사이즈 20으로 지정
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        }
        // 셀 색상을 투명하게
        cell.backgroundColor = UIColor.clear
        return cell
    }
}
