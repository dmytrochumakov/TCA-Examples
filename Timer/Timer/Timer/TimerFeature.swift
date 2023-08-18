//
//  TimerFeature.swift
//  Timer
//
//  Created by Dmytro Chumakov on 18.08.2023.
//

import ComposableArchitecture

struct TimerFeature: Reducer {
    var body: some ReducerOf<TimerFeature> {
        Reduce { state, action in
            switch action {
            case .startTapped:
                state.isTimerActive = true
                return .none
            case .stopTapped:
                state.isTimerActive = false
                return .none
            }
        }
    }
    enum Action: Equatable {
        case startTapped
        case stopTapped
    }
    struct State: Equatable {
        var isTimerActive = false
    }
}