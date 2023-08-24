//
//  TimerTests.swift
//  TimerTests
//
//  Created by Dmytro Chumakov on 17.08.2023.
//

import ComposableArchitecture
import XCTest
@testable import Timer

@MainActor
final class TimerTests: XCTestCase {

    func testTogglginTimer() async throws {
        let store = TestStore(initialState: TimerFeature.State()) {
            TimerFeature()
        }

        await store.send(.startTapped) {
            $0.isTimerActive = true
        }

        await store.send(.stopTapped) {
            $0.isTimerActive = false
        }
    }

}
