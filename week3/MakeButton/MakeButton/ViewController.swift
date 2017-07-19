//
//  ViewController.swift
//  MakeButton
//
//  Created by yangpc on 2017. 7. 18..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        let myButton = MyButton(frame: CGRect(x: self.view.frame.width/2-40, y: self.view.frame.height - 200, width: 80, height: 40))
        
        // normal
        myButton.setTitle("normal", for: .normal)
        myButton.setTitleColor(UIColor.yellow, for: .normal)
        // normal & highlight
        myButton.setTitle("highlight1", for: .highlighted)
        myButton.setTitleColor(UIColor.white, for: .highlighted)
        // selected
        myButton.setTitle("selected", for: .selected)
        myButton.setTitleColor(UIColor.green, for: .selected)
        // selected & highlignt
        myButton.setTitle("highlight2", for: [.selected, .highlighted])
        myButton.setTitleColor(UIColor.red, for: [.selected, .highlighted])
        
        myButton.setMyBackgroundColor(UIColor.black)
        
        // myButton.addTarget(target: self, selector: #selector(Login))
        view.addSubview(myButton)
        
        let myButton2 = MyButton(frame: CGRect(x: self.view.frame.width/2-40, y: self.view.frame.height - 150, width: 80, height: 40))
        
        myButton2.setTitle("Disable the button", for: .normal)
        myButton2.setTitle("Enable the button", for: .selected)
        
        // myButton.addTarget(target: self, selector: #selector(makeDisable()))
        view.addSubview(myButton2)
    }
    /*
    private func makeDisable() {
        if 
    }
    */
    
}

