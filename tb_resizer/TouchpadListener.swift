//
//  bg_touch.swift
//  tb_resizer
//
//  Created by skylatian on 1/24/25.
// very similar to https://github.com/Kyome22/OpenMultitouchSupport/blob/main/Demo/OMSDemo/ContentViewModel.swift

import OpenMultitouchSupport
import Foundation


final class TouchpadListener: ObservableObject {
    @Published var touchData = [OMSTouchData]() // this is the touch data that I can access elsewhere if needed, updated in real time
    @Published var isListening: Bool = false
    
    private let manager = OMSManager.shared
    private var task: Task<Void, Never>?
    
    static let shared = TouchpadListener() // call this elsewhere to start or stop the listener (TouchpadListener.shared.start()/stop())
    
    private init() {}

    func start() {
        guard task == nil else { return } // make sure task isn't running already

        task = Task { [weak self, manager] in
            for await touchData in manager.touchDataStream {
                await MainActor.run { [weak self] in
                    self?.touchData = touchData
                    // this is where touch data is grabbed. if you want to do something with it, call a function here
                    print(touchData)
                }
            }
        }

        if manager.startListening() {
            isListening = true
            print("TouchpadListener: Listening started.")
        } else {
            print("TouchpadListener: Failed to start listening.")
        }
    }

    func stop() {
        task?.cancel()
        task = nil

        if manager.stopListening() {
            isListening = false
            print("TouchpadListener: Listening stopped.")
        } else {
            print("TouchpadListener: Failed to stop listening.")
        }
    }

    deinit {
        stop()
    }
}
