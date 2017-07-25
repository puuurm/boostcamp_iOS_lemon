//
//  ViewController.swift
//  OneToTwentyfiveGame
//
//  Created by yangpc on 2017. 7. 24..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var recordBook: RecordBook!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowPlay"?:
            let destinationController = segue.destination as! PlayViewController
            destinationController.recordBook = self.recordBook
        case "ShowHistory"?:
            let destinationController = segue.destination as! RecordsViewController
            destinationController.recordBook = self.recordBook
        default: break
        }
    }
}

