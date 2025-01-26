//
//  ContentView.swift
//  tb_resizer
//
//  Created by skylatian on 1/24/25.
//

import SwiftUI
import LaunchAtLogin

import OpenMultitouchSupport

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

struct VisualizationView: View {
    @ObservedObject private var touchpadListener = TouchpadListener.shared // use shared touch data

    var body: some View {
        VStack {
            Canvas { context, size in
                touchpadListener.touchData.forEach { touch in
                    let path = makeEllipse(touch: touch, size: size)
                    context.fill(path, with: .color(.primary.opacity(Double(touch.total))))
                }
            }
            .frame(width: 600, height: 400)
            .border(Color.primary)
        }
        .fixedSize()
        .padding()
        .onAppear {
            print("Visualization started.")
        }
        .onDisappear {
            print("Visualization stopped.")
        }
    }

    private func makeEllipse(touch: OMSTouchData, size: CGSize) -> Path {
        let x = Double(touch.position.x) * size.width
        let y = Double(1.0 - touch.position.y) * size.height
        let pressureScale = 10.0//00.0 // Adjust the scaling factor for size based on pressure
        let w = pressureScale //* Double(touch.total) // Using pressure to scale size
        let h = pressureScale //* Double(touch.total)
        return Path(ellipseIn: CGRect(x: x - w / 2, y: y - h / 2, width: w, height: h))
    }
}

#Preview {
    VisualizationView()
}
