//
//  ContentView.swift
//  Timer
//
//  Created by Dmytro Chumakov on 17.08.2023.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    let store: StoreOf<TimerFeature>
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: .zero) {
                Text(String(viewStore.secondsElapsed))
                    .foregroundColor(.blue)
                Button(
                    action: {
                        if viewStore.isTimerActive {
                            viewStore.send(.stopTapped)
                        } else {
                            viewStore.send(.startTapped)
                        }
                    }, label: {
                        Image(systemName: viewStore.isTimerActive ? "stop.circle.fill" : "play.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)                            
                })
                TextField("", text: viewStore.binding(
                    get: \.timerTitle,
                    send: { .timerTitleChanged($0) }),
                          prompt: Text("Set some text"))
            }
        }
    }
}

#Preview {
    ContentView(
        store: Store(initialState: TimerFeature.State()) {
            TimerFeature()._printChanges()
        }
    )
}
