//
//  tb_resizerApp.swift
//  tb_resizer
//
//  Created by skylatian on 1/24/25.
//

import SwiftUI
import LaunchAtLogin
import OpenMultitouchSupport
import Foundation

// this handles the menu bar UI and settings window, as well as app lifecyle

@main
struct tb_resizerApp: App {
    @State var currentNumber: String = "1"
    @State private var isSettingsWindowOpen: Bool = false
    @State private var settingsWindowController: NSWindowController?
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate // add AppDelegate for lifecycle managment

    init() {
        TouchpadListener.shared.start() // start the touchpad listening service
    }
    
    var body: some Scene {
        
        MenuBarExtra(currentNumber, systemImage: "\(currentNumber).circle") {
            Button("One") {
                currentNumber = "1"
            }
            .keyboardShortcut("1")
            Button("Two") {
                currentNumber = "2"
            }
            .keyboardShortcut("2")
            Button("Three") {
                currentNumber = "3"
            }
            .keyboardShortcut("3")
            
            Button("Settings") {
                openSettingsWindow()
            }
            .keyboardShortcut(",")
            
            Divider()
            
            LaunchAtLogin.Toggle()
            
            Button("Quit") {
                
                NSApplication.shared.terminate(nil)
                
            }.keyboardShortcut("q")
            
        }
    }
    
    // open settings window with NSWindowController
    private func openSettingsWindow() {
        if let settingsWindowController = settingsWindowController {
            // if window exists, bring to the front
            settingsWindowController.window?.makeKeyAndOrderFront(nil)
        } else {
            // otherwise, make a new one
            let settingsView = VisualizationView()
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
                styleMask: [.titled, .closable, .resizable],
                backing: .buffered,
                defer: false
            )
            window.title = "Settings"
            window.center()
            window.contentView = NSHostingView(rootView: settingsView)
            settingsWindowController = NSWindowController(window: window)
            settingsWindowController?.window?.makeKeyAndOrderFront(nil)
        }
        
        // bring window to foreground
        NSApp.activate(ignoringOtherApps: true)
    }
}

// MARK: - AppDelegate for NSApplication Lifecycle Management
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationWillTerminate(_ notification: Notification) {
        TouchpadListener.shared.stop()
        print("AppDelegate: Application is terminating. TouchpadListener stopped.")
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        print("AppDelegate: Application did finish launching.")
    }
}
