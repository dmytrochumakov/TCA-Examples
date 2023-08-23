//
//  TimerApp.swift
//  Timer
//
//  Created by Dmytro Chumakov on 17.08.2023.
//

import ComposableArchitecture
import SwiftUI

@main
struct TimerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(initialState: TimerFeature.State()) {
                    TimerFeature()._printChanges()
                }
            )
        }
    }
}
