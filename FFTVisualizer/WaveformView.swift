//
//  WaveformView.swift
//  AudioTutorialSwift
//
//  Created by Mike Muszynski on 12/16/15.
//  Copyright © 2015 Mike Muszynski. All rights reserved.
//

import Cocoa

class WaveformView: NSView {
    
    @IBOutlet weak var noDataTextField: NSTextField!
    
    var mode = 0 {
        didSet {
            self.setNeedsDisplayInRect(self.bounds)
        }
    }
    
    var fftData = [Float]() {
        didSet {
            self.setNeedsDisplayInRect(self.bounds)
        }
    }
    
    var waveformData = [Float]() {
        didSet {
            self.setNeedsDisplayInRect(self.bounds)
        }
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        let border = NSBezierPath(rect: self.bounds)
        border.stroke()
        
        noDataTextField.hidden = true
        
        let data = mode == 0 ? waveformData : fftData
        
        guard data.count > 0 else {
            noDataTextField.hidden = false
            return
        }
        
        guard let max = data.maxElement() else {
            return
        }
        
        let wave = NSBezierPath()
        
        for (index, floatValue) in data.enumerate() {
            let x = CGFloat(index) * self.bounds.size.width / CGFloat(data.count)
            var y = self.bounds.size.height * CGFloat(floatValue) / CGFloat(max)
            
            if mode == 0 {
                y = y * 0.5 + self.bounds.size.height / 2.0
            }
            let point = NSPoint(x: x, y: y)
            //Swift.print(NSStringFromPoint(point))
            
            if index == 0 {
                wave.moveToPoint(point)
            } else {
                wave.lineToPoint(point)
            }
        }
        
        NSColor.blackColor().set()
        wave.stroke()


        // Drawing code here.
    }
    
}
