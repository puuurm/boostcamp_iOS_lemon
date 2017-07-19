//
//  MyButton.swift
//  MakeButton
//
//  Created by yangpc on 2017. 7. 18..
//  Copyright © 2017년 yang hee jung (lemon). All rights reserved.
//

import UIKit

class MyButton: UIView, UIGestureRecognizerDelegate {
    
    private var textLabel: UILabel!
    private var backgroundImageView: UIImageView!
    
    private var textOnState: [Int: String] = [Int: String]()
    private var colorOnState: [Int: UIColor] = [Int: UIColor]()
    
    private var state: StateOptions = .normal {
        didSet {
            updateButton()
        }
    }
    
    open var isSelected: Bool {
        get {
            return self.state.contains(.selected)
        }
    }
    
    open var isEnabled: Bool = true {
        didSet {
            if isEnabled {
                isUserInteractionEnabled = true
                self.alpha = 1
            } else {
                isUserInteractionEnabled = false
                self.alpha = 0.5
            }
        }
    }
    
    open var isHighLighted: Bool = false {
        didSet {
            if isHighLighted {
                state.insert(.highlighted)
                self.alpha = 0.5
            } else {
                if state.contains(.normal) {
                    state = [.selected]
                } else {
                    state = [.normal]
                }
                self.alpha = 1
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initImageView()
        initLabel()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLabel() {
        textLabel = UILabel()
        addSubview(textLabel)
        
        textLabel?.textAlignment = .center
        textLabel?.translatesAutoresizingMaskIntoConstraints = false
        textLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textLabel?.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        textLabel?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
        
    }
    func initImageView() {
        backgroundImageView = UIImageView()
        addSubview(backgroundImageView)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    }
    
    func setTitle(_ title: String?, for state: StateOptions) {
        textOnState[Int(state.rawValue)] = title
        updateButton()
    }
    
    func setTitleColor(_ color: UIColor?, for state: StateOptions) {
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
        textLabel.text = textOnState[state.rawValue]
    }
    func updateColor() {
        textLabel.textColor = colorOnState[state.rawValue]
    }
    
    func addTarget(_ target: Any?, action: Selector) {
        let tapRecognizer = UITapGestureRecognizer(target: target, action: action)
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.delegate = self
        tapRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(tapRecognizer)
    }
    // implements gesture delegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    // highlight
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isHighLighted = true
        
    }
    // normal, selected
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isHighLighted = false
        
    }
}

struct StateOptions: OptionSet {
    var rawValue: Int
    
    static let normal    = StateOptions(rawValue: 1 << 0)
    static let highlighted  = StateOptions(rawValue: 1 << 1)
    static let disabled   = StateOptions(rawValue: 1 << 2)
    static let selected   = StateOptions(rawValue: 1 << 3)
}
