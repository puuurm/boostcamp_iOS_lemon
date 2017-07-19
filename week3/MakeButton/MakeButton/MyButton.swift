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
    

    var textOnState: [UInt: String] = [UInt: String]()
    var colorOnState: [UInt: UIColor] = [UInt: UIColor]()
    
    /* UIControlState()로 생성된 기본값이 normal인지 모른다면 헷갈릴 수 있겠죠? 조금 더 명확히 써주는 것이 좋겠습니다 */
    var state = UIControlState.normal {

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

        
        /* 차후에 시간이 허락한다면 오토 레이아웃도 적용해 봅시다 */
        self.textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: self.frame.height))
        backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: self.frame.height))

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setTitle(_ title: String?, for state: UIControlState) {

        textOnState[state.rawValue] = title
        updateButton()
    }
    

    func setTitleColor(_ color: UIColor?, for state: UIControlState) {

        colorOnState[state.rawValue] = color
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
            if stateIndex == state.rawValue {
                textLabel.text = text
            }
        }
    }
    func updateColor() {
        for (stateIndex, color) in colorOnState {
            if stateIndex == state.rawValue {
                textLabel.textColor = color
            }
        }

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
