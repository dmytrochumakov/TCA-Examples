//
//  TimerTests.swift
//  TimerTests
//
//  Created by Dmytro Chumakov on 17.08.2023.
//

import ComposableArchitecture
import XCTest
@testable import Timer

let clock = TestClock()

@MainActor
final class TimerTests: XCTestCase {

    func testTogglginTimer() async throws {
        let store = TestStore(initialState: TimerFeature.State()) {
            TimerFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }

        await store.send(.startTapped) {
            $0.isTimerActive = true
        }

        await clock.advance(by: .seconds(3))
        await store.receive(.timerTicked) { $0.secondsElapsed = 1 }
        await store.receive(.timerTicked) { $0.secondsElapsed = 2 }
        await store.receive(.timerTicked) { $0.secondsElapsed = 3 }

        await store.send(.stopTapped) {
            $0.isTimerActive = false
            $0.secondsElapsed = 0
        }
    }

}
