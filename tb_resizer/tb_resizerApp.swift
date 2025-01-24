//
//  tb_resizerApp.swift
//  tb_resizer
//
//  Created by skylatian on 1/24/25.
//

import SwiftUI

@main
struct swiftui_menu_barApp: App {
    @State var currentNumber: String = "1"
    
    var body: some Scene {
        //WindowGroup {
            //ContentView()
        //}
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
            Divider()

            Button("Quit") {

                NSApplication.shared.terminate(nil)

            }.keyboardShortcut("q")

        }
    }
}
