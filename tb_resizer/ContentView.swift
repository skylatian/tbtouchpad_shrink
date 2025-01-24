//
//  ContentView.swift
//  tb_resizer
//
//  Created by skylatian on 1/24/25.
//
//
import SwiftUI

// this file handles the visual (UI) components only

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
        }
        .frame(minWidth: 300, minHeight: 200)
    }
    
    // close the current settings window
    private func closeWindow() {
        NSApp.keyWindow?.close()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

#Preview {
    SettingsView()
}
