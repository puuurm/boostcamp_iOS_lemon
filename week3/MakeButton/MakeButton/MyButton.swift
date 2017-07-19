//
//  MyButton.swift
//  MakeButton
//
//  Created by yangpc on 2017. 7. 18..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class MyButton: UIView {
    
    var textLabel: UILabel!
    var backgroundImageView: UIImageView!
    
    var textOnState: [Int: String] = [Int: String]()
    var colorOnState: [Int: UIColor] = [Int: UIColor]()
    
    var state = UIControlState() {
        didSet {
            updateButton()
        }
    }
    
    open var originalTextColor: UIColor = UIColor.black
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: self.frame.height))
        backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: self.frame.height))
        
        self.state = .normal
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ title: String?, for state: UIControlState) {
        textOnState[Int(state.rawValue)] = title
        updateButton()
    }
    
    func setTitleColor(_ color: UIColor?, for state: UIControlState) {
        colorOnState[Int(state.rawValue)] = color
        updateButton()
    }
    func setMyBackgroundColor(_ color: UIColor) {
        backgroundImageView.backgroundColor = color
    }
    func updateButton() {
        updateTitle()
        updateColor()
        
    }
    func updateTitle() {
        for (stateIndex, text) in textOnState {
            if stateIndex == Int(state.rawValue) {
                textLabel.text = text
            }
        }
    }
    func updateColor() {
        for (stateIndex, color) in colorOnState {
            if stateIndex == Int(state.rawValue) {
                textLabel.textColor = color
            }
        }
    }
    
    // highlight
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
        if state == .normal {
            state = .highlighted
        } else {
            state = state.union(.highlighted)
        }
    }
    // normal, selected
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded")
        if state == .highlighted {
            state = .selected
        } else {
            state = .normal
        }
    }
}
