//
//  TimerFeature.swift
//  Timer
//
//  Created by Dmytro Chumakov on 18.08.2023.
//

import ComposableArchitecture

struct TimerFeature: Reducer {
    @Dependency(\.continuousClock) var clock

    var body: some ReducerOf<TimerFeature> {
        Reduce { state, action in
            switch action {
            case .startTapped:
                state.isTimerActive = true
                return .run { send in
                    for await _ in clock.timer(interval: .seconds(1)) {
                        await send(.timerTicked)
                    }
                }
                .cancellable(id: TimerCancelID.cancel)
            case .stopTapped:
                state.isTimerActive = false
                state.secondsElapsed = 0
                return .cancel(id: TimerCancelID.cancel)
            case .timerTitleChanged(let newTitle):
                state.timerTitle = newTitle
                return .none
            case .timerTicked:
                state.secondsElapsed += 1
                return .none
            }
        }
    }
    enum Action: Equatable {
        case startTapped
        case stopTapped
        case timerTitleChanged(String)
        case timerTicked
    }
    struct State: Equatable {
        var isTimerActive = false
        var timerTitle = ""
        var secondsElapsed = 0
    }
}

private enum TimerCancelID { case cancel }
