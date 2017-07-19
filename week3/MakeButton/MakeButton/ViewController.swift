//
//  ViewController.swift
//  MakeButton
//
//  Created by yangpc on 2017. 7. 18..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myButton: MyButton!
    var myButton2: MyButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButton()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func makeButton() {
        myButton = MyButton(frame: CGRect(x: self.view.frame.width/2-100, y: self.view.frame.height - 300, width: 200, height: 50))
        
        // normal
        myButton.setTitle("normal", for: .normal)
        myButton.setTitleColor(UIColor.yellow, for: .normal)
        // normal & highlight
        myButton.setTitle("highlight1", for: [.normal, .highlighted])
        myButton.setTitleColor(UIColor.white, for: [.normal,.highlighted])
        // selected
        myButton.setTitle("selected", for: .selected)
        myButton.setTitleColor(UIColor.green, for: .selected)
        // selected & highlignt
        myButton.setTitle("highlight2", for: [.selected, .highlighted])
        myButton.setTitleColor(UIColor.red, for: [.selected, .highlighted])
        
        myButton.setMyBackgroundColor(UIColor.black)
        
        myButton.addTarget(self, action: #selector(self.printTouchUpInside(_:)))
        view.addSubview(myButton)
        
        myButton2 = MyButton(frame: CGRect(x: self.view.frame.width/2-100, y: self.view.frame.height - 250, width: 200, height: 50))
        
        myButton2.setTitle("Disable the button", for: .normal)
        myButton2.setTitle("Enable the button", for: .selected)
        myButton2.addTarget(self, action: #selector(self.makeDisable(_:)))
        
        // myButton.addTarget(target: self, selector: #selector(makeDisable()))
        view.addSubview(myButton2)
    }
    func makeDisable(_ sender: Any) {
        if myButton2.isSelected {
            myButton.isEnabled = true
            
        } else {
            myButton.isEnabled = false
        }
    }
    
    func printTouchUpInside(_ sender: Any) {
        if myButton.isEnabled {
            print("touch up inside")
            print("button tapped")
        }
    }
    
}

