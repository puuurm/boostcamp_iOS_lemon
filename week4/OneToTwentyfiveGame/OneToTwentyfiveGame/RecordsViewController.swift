//
//  RecordsViewController.swift
//  OneToTwentyfiveGame
//
//  Created by yangpc on 2017. 7. 25..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class RecordsViewController: UIViewController {
    
    open var recordBook: RecordBook!
    @IBOutlet var recordTableView: UITableView!
    

    private lazy var closeButton: UIButton = { [unowned self] in
        let closeButton = UIButton()
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = UIColor.red
        closeButton.titleLabel?.font = closeButton.titleLabel?.font.withSize(20)
        closeButton.addTarget(
            self,
            action: #selector(RecordsViewController.showMainView(_:)),
            for: .touchUpInside
        )
        closeButton.addTarget(
            self,
            action: #selector(RecordsViewController.dismissView(_:)),
            for: .touchUpInside
        )
        return closeButton
    }()
    
    private lazy var resetButton: UIButton = { [unowned self] in
        let resetButton = UIButton()
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.backgroundColor = UIColor.red
        resetButton.titleLabel?.font = resetButton.titleLabel?.font.withSize(20)
        return resetButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCloseButton()
        initResetButton()
        // Do any additional setup after loading the view, typically from a nib.
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        recordTableView.contentInset = insets
        recordTableView.scrollIndicatorInsets = insets
        recordTableView.dataSource = self
    }
    
    func initCloseButton() {
        view.addSubview(closeButton)
        closeButton.titleLabel?.textAlignment = .center
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        closeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    }
    func initResetButton() {
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

extension RecordsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordBook.allRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordCell
        let record = recordBook.allRecords[indexPath.row]
        cell.nameLabel.text = record.name
        cell.timeLabel.text = "\(record.startDate)"
        cell.timerLabel.text = "\(record.clearTime)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let record = recordBook.allRecords[indexPath.row]
            recordBook.removeRecord(record: record)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
