//
//  DrawView.swift
//  TouchTracker
//
//  Created by yangpc on 2017. 7. 11..
//  Copyright © 2017년 yangpc. All rights reserved.
//

import UIKit

class DrawView: UIView {
    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()
    
    @IBInspectable var finishedLineColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineThickness: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /* 그리기 */
    func stroke(_ line: Line) {
        let path = UIBezierPath()   //A path that consists of straight and curved line segments
        path.lineWidth = lineThickness
        path.lineCapStyle = CGLineCap.round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        finishedLineColor.setStroke()
        for line in finishedLines {
            // 각도마다 색이 다르게.
            let vectorValue = CGPoint(x:line.end.x - line.begin.x, y: line.begin.y - line.end.y)
            var angle = atan2(Float(vectorValue.y), Float(vectorValue.x)) * Float(180/Double.pi)
            
            if angle < 0 {
                angle = (angle + 360).truncatingRemainder(dividingBy: 360.0)
            }
            print(angle)
            switch angle {
            case 0..<90:
                UIColor.brown.setStroke()
            case 90..<180:
                UIColor.cyan.setStroke()
            case 180 ..< 270:
                UIColor.orange.setStroke()
            default:
                UIColor.magenta.setStroke()
            }
            
            stroke(line)
        }
        currentLineColor.setStroke()
        for (_, line) in currentLines {
            stroke(line)
        }
    }
    /* 터치를 선으로 변환하기 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        for touch in touches {
            let location = touch.location(in: self)
            let newLine = Line(begin: location, end: location)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.location(in: self)
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key] {
                line.end = touch.location(in: self)
                finishedLines.append(line)
                currentLines.removeValue(forKey: key)
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        currentLines.removeAll()
        setNeedsDisplay()
    }
}
