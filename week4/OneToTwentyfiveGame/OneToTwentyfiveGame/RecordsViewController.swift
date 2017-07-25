//
//  RecordsViewController.swift
//  OneToTwentyfiveGame
//
//  Created by yangpc on 2017. 7. 25..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class RecordsViewController: UITableViewController {
    var closeButton: UIButton = UIButton()
    var resetButton: UIButton = UIButton()
    var recordBook: RecordBook!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func initView() {
        initCloseButton()
        initResetButton()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordBook.allRecords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordCell
        let record = recordBook.allRecords[indexPath.row]
        cell.nameLabel.text = record.name
        cell.timeLabel.text = "\(record.startDate)"
        cell.timerLabel.text = "\(record.clearTime)"
        return cell
    }
    
    func initCloseButton() {
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = UIColor.red
        closeButton.titleLabel?.font = closeButton.titleLabel?.font.withSize(20)
        closeButton.addTarget(self, action: #selector(RecordsViewController.showMainView(_:)), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(RecordsViewController.dismissView(_:)), for: .touchUpInside)
        view.addSubview(closeButton)
        
        closeButton.titleLabel?.textAlignment = .center
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        closeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    }
    func initResetButton() {
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.backgroundColor = UIColor.red
        resetButton.titleLabel?.font = resetButton.titleLabel?.font.withSize(20)
        view.addSubview(resetButton)
        
        resetButton.titleLabel?.textAlignment = .center
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        resetButton.widthAnchor.constraint(equalTo: closeButton.widthAnchor).isActive = true
    }
    
    func showMainView(_ btControl: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func dismissView(_ btControl: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
