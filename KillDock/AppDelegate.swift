//
//  AppDelegate.swift
//  KillDock
//
//  Created by Vasilii Zolotukhin on 27/04/16.
//  Copyright © 2016 Vasilii Zolotukhin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    let menu = NSMenu()
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        // Insert code here to initialize your application
        if let buttonItem = statusItem.button {
            
            buttonItem.image = NSImage(named: "StatusBarButtonImage")
            buttonItem.target = self
            buttonItem.action = #selector(AppDelegate.statusItemClicked(_:))
            buttonItem.menu = menu
            
            buttonItem.sendActionOn(Int(NSEventMask.RightMouseUpMask.rawValue | NSEventMask.LeftMouseUpMask.rawValue))
            
        }
        
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(AppDelegate.Quit(_:)), keyEquivalent: ""))
        
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        
        // Insert code here to tear down your application
        
    }
    
    func statusItemClicked(sender: AnyObject) {

        let event:NSEvent! = NSApp.currentEvent!
        
        if (event.type == NSEventType.RightMouseUp) {
            
            statusItem.menu = menu
            statusItem.popUpStatusItemMenu(menu)
            
        } else {
            
            var errorDict: NSDictionary? = nil
            let appleScript = NSAppleScript(source: "do shell script \"killall Dock\"")
            _ = appleScript?.executeAndReturnError(&errorDict)
            
            if errorDict != nil {
                
                //
                
            }
            
        }
        
    }
    
    func Quit(sender: AnyObject) {
        
        NSApplication.sharedApplication().terminate(sender)
        
    }
    
}

