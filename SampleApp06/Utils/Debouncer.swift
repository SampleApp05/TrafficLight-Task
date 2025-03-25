//
//  Debouncer.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 24.03.25.
//

import Foundation

class Debouncer {
    typealias DebounceTask = Task<Void, Never>
    
    var debounceTask: DebounceTask?
    
    func startDebounceTask(delay: TimeInterval, completion: @escaping VoidClosure) {
        cancelDebounceTask()
        
        debounceTask = Task {
            do {
                try await Task.sleep(nanoseconds: delay.inNanoSeconds)
                
                guard Task.isCancelled == false else { return }
                
                await MainActor.run {
                    completion()
                }
            } catch {
                print("Debounce Task failed with error: \(error)")
            }
        }
    }
    
    func cancelDebounceTask() {
        debounceTask?.cancel()
        debounceTask = nil
    }
}
