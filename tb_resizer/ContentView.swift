//
//  ContentView.swift
//  tb_resizer
//
//  Created by skylatian on 1/24/25.
//

import SwiftUI
import LaunchAtLogin

// this file handles the visual (UI) components only - in this case, just the settings *window*. We'll get back to this later

struct SettingsView: View {

    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .padding()
            
            Button("Close Settings") {
                closeWindow()
            }
            .padding()
            LaunchAtLogin.Toggle()
        }
        .frame(minWidth: 300, minHeight: 200)
    }
    
    // close the current settings window
    private func closeWindow() {
        NSApp.keyWindow?.close()
    }
}

#Preview {
    SettingsView()
}
