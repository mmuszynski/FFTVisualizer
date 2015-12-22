//
//  AppDelegate.swift
//  AudioTutorialSwift
//
//  Created by Mike Muszynski on 12/16/15.
//  Copyright © 2015 Mike Muszynski. All rights reserved.
//

import Cocoa

extension Int {
    func toUInt32() -> UInt32 {
        return UInt32(self)
    }
    func toInt32() -> Int32 {
        return Int32(self)
    }
}

extension Int32 {
    func toUInt32() -> UInt32 {
        return UInt32(self)
    }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    @IBOutlet weak var waveformViewer: WaveformView!
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var urlTextField: NSTextField!
    
    var fft = [Float]()

    func applicationDidFinishLaunching(aNotification: NSNotification) {

        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func analyzeNewFile(sender: AnyObject) {
        //get url
        let path = urlTextField.stringValue
        let url = NSURL(fileURLWithPath: path)
        let analyzer = FFTAnalzer(url: url)
        
        do {
            try analyzer.performAnalysis()
            waveformViewer.fftData = analyzer.fftOutput
            waveformViewer.waveformData = analyzer.audioData
        } catch {
            let theError = error as! FFTAnalyzerError
            
            waveformViewer.fftData = [Float]()
            let alert = NSAlert()
            alert.messageText = "Error"
            alert.informativeText = theError.description()
            alert.alertStyle = NSAlertStyle.WarningAlertStyle
            alert.addButtonWithTitle("OK")
            alert.beginSheetModalForWindow(self.window, completionHandler: nil)
        }
    }
    
    @IBAction func controlDidChange(sender: AnyObject) {
        
        if let control = sender as? NSSegmentedControl {
            waveformViewer.mode = control.selectedSegment
        }
        
    }
    

}

