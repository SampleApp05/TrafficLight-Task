//
//  DebouncerTests.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 24.03.25.
//

import Testing
@testable import SampleApp06
import Foundation

struct DebouncerTests {
    private let debouncer: Debouncer
    
    init() {
        self.debouncer = Debouncer()
    }
    
    @Test("Debouncer should run after a delay")
    func testDebounceExecution() async throws {
        let startDate = Date.now // easier to compare
        let delay: TimeInterval = 1.0
        let expectedDate = startDate + delay
        var executionDate: Date?
        
        await withCheckedContinuation { (continuation) in
            self.debouncer.startDebounceTask(delay: delay) {
                executionDate = Date.now
                continuation.resume()
            }
        }
        
        #expect(executionDate != nil, "Execution date should not be nil")
        #expect(executionDate! >= expectedDate, "Execution date should be after the delay")
    }
    
    @Test("Debouncer should run only the last task")
    func testDebounceExecutionLastTask() async throws {
        var firstTaskExecuted = false
        var secondTaskExecuted = false
        
        debouncer.startDebounceTask(delay: 0.0000001) {
            firstTaskExecuted = true
        }
        
        debouncer.startDebounceTask(delay: 0.25) {
            secondTaskExecuted = true
        }
        
        try await Task.sleep(nanoseconds: 0.5.inNanoSeconds) // Wait for the 2nd task to finish
        
        #expect(firstTaskExecuted == false, "The first task should have been cancelled.")
        #expect(secondTaskExecuted, "The second task should have executed.")
    }
}
