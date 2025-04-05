//
//  ActivateMacApp.swift
//  ActivateMac
//
//  Created by Bùi Đặng Bình on 5/4/25.
//

import SwiftUI

@main
struct ActivateMacApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    var watermarkWindow: NSWindow!
    var isVisible = true

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        createWatermarkWindow()
        setupStatusBarItem()
    }

    func createWatermarkWindow() {
        let contentView = WatermarkView()

        // bottom right corner pos
        let screenFrame = NSScreen.main?.visibleFrame ?? .zero
        let windowSize = NSSize(width: 250, height: 60)
        let windowOrigin = NSPoint(
            x: screenFrame.maxX - windowSize.width - 20,
            y: screenFrame.minY + 20
        )

        watermarkWindow = NSWindow(
            contentRect: NSRect(origin: windowOrigin, size: windowSize),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )

        watermarkWindow.contentView = NSHostingView(rootView: contentView)
        watermarkWindow.backgroundColor = .clear
        watermarkWindow.isOpaque = false
        watermarkWindow.hasShadow = false
        watermarkWindow.level = .floating
        watermarkWindow.ignoresMouseEvents = true
        watermarkWindow.collectionBehavior = [.canJoinAllSpaces, .stationary]

        watermarkWindow.makeKeyAndOrderFront(nil)
    }

    func setupStatusBarItem() {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusBarItem.button {
            button.title = "WM"
        }

        let menu = NSMenu()

        menu.addItem(NSMenuItem(title: "Toggle Watermark", action: #selector(toggleWatermark(_:)), keyEquivalent: "t"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp(_:)), keyEquivalent: "q"))

        statusBarItem.menu = menu
    }

    @objc func toggleWatermark(_ sender: NSMenuItem) {
        isVisible.toggle()

        if isVisible {
            watermarkWindow.makeKeyAndOrderFront(nil)
        } else {
            watermarkWindow.orderOut(nil)
        }
    }

    @objc func quitApp(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
}
