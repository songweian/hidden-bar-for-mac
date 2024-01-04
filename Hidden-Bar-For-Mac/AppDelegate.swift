//
//  AppDelegate.swift
//  Hidden Bar For Mac
//
//  Created by swa-c on 2024/1/4.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusBarItem: NSStatusItem!
    var hidden: Bool = false
    var settingSpm = "ellipsis"
    var expandSym = "lessthan"
    var compactSym = "arrow.left.to.line.compact"
    var buttonRight: NSButton!
    var buttonLeft: NSButton!
    var xview:NSStackView!
    let statusBarItemLength: CGFloat = 25
    let statusBarItemExpandLength: CGFloat = NSScreen.main?.frame.width ?? 50

    func applicationDidFinishLaunching(
        _ aNotification: Notification
    ) {
        // 隐藏dock图标
        NSApp.setActivationPolicy(
            .accessory
        )
        //
        let menuBarHeight = NSStatusBar.system.thickness
        //
        statusBarItem = NSStatusBar.system.statusItem(
            // withLength: 50
            withLength: statusBarItemLength
        )
        // button left
        buttonLeft = NSButton()
        //        buttonLeft.title = "|"
        buttonLeft.image = NSImage(
            systemSymbolName : settingSpm,
            accessibilityDescription: nil
        )
        // buttonLeft.frame = NSRect(
        //     x: 0,
        //     y: 0,
        //     width: 30,
        //     height: menuBarHeight
        // )
        buttonLeft.rotate(
            byDegrees: 90
        )
        buttonLeft.bezelStyle = .regularSquare
        buttonLeft.isBordered = false
        buttonLeft.wantsLayer = true
        buttonLeft.layer?.backgroundColor = NSColor.clear.cgColor
        buttonLeft.action = #selector(
            openSettings(_:)
        )
        
        // button right
        buttonRight = NSButton()
        buttonRight.image = NSImage(
            systemSymbolName : expandSym,
            accessibilityDescription: nil
        )
        // buttonRight.frame = NSRect(
        //     x: 15,
        //     y: 0,
        //     width: 30,
        //     height: menuBarHeight
        // )
        
        buttonRight.bezelStyle = .regularSquare
        buttonRight.isBordered = false
        buttonRight.wantsLayer = true
        buttonRight.layer?.backgroundColor = NSColor.clear.cgColor
        buttonRight.action = #selector(
            toggleExpand(_:)
        )
        
        xview = NSStackView(views: [buttonLeft, buttonRight])
        xview.spacing = 0
        xview.orientation = .horizontal
        xview.distribution = .gravityAreas
        xview.alignment = .centerY
        xview.userInterfaceLayoutDirection = .rightToLeft
        xview.translatesAutoresizingMaskIntoConstraints = false

        xview.addArrangedSubview(buttonRight)
        xview.addArrangedSubview(buttonLeft)
        
        xview.wantsLayer = true
        xview.layer?.borderColor = NSColor.red.cgColor
        xview.layer?.borderWidth = 1

        statusBarItem.view = xview
    }
    @objc func openSettings(
        _ sender: NSButton
    ) {
        print("打开设置")
    }
    @objc func toggleExpand(
        _ sender: NSButton
    ) {
        print("Right side clicked")
        hidden = !hidden
        if hidden  {
            buttonRight.image = NSImage(systemSymbolName: compactSym, accessibilityDescription: nil)
            // 设置显示隐藏buttonLeft
            buttonLeft.isHidden = true
            statusBarItem.length = 150
            // NSLayoutConstraint.activate([
            //     xview.widthAnchor.constraint(equalToConstant: statusBarItemExpandLength)
            // ])
        } else {
            buttonRight.image = NSImage(systemSymbolName: expandSym, accessibilityDescription: nil)
            buttonLeft.isHidden = false
            statusBarItem.length = statusBarItemLength
        }
    }
    
    func applicationWillTerminate(
        _ aNotification: Notification
    ) {
        // Insert code here to tear down your application
    }
    
    func applicationSupportsSecureRestorableState(
        _ app: NSApplication
    ) -> Bool {
        return true
    }
}
