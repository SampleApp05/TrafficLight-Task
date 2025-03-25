//
//  TrafficLightViewModel.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 25.03.25.
//

import SwiftUI

enum TrafficLightState {
    case go
    case stopIfSafe
    case stop
    case getReady
    
    var duration: TimeInterval {
        switch self {
        case .go: return 4.0
        case .stopIfSafe: return 1.0
        case .stop: return 3.0
        case .getReady: return 1.0
        }
    }
}

enum TrafficLight: CaseIterable {
    case red
    case orange
    case green
    
    var color: Color {
        switch self {
        case .green: return .green
        case .orange: return .orange
        case .red: return .red
        }
    }
}

@Observable
final class TrafficLightViewModel: Debouncer, CoordinatorViewModel, TrafficLightViewHandler {
    private(set) weak var coordinator: AppCoordinator?
    
    private(set) var isDriving = false
    let carModelName: String
    var trafficLightState: TrafficLightState = .go
    
    var actionButtonTitle: String { isDriving ? "Stop driving" : "Start driving" }
    
    var nextTrafficLightState: TrafficLightState {
        switch trafficLightState {
        case .go: return .stopIfSafe
        case .stopIfSafe: return .stop
        case .stop: return .getReady
        case .getReady: return .go
        }
    }
    
    init(
        coordinator: AppCoordinator,
        carModelName: String
    ) {
        self.coordinator = coordinator
        self.carModelName = carModelName
    }
    
    // MARK: - Private
    private func transitionToNextState() {
        let nextState = nextTrafficLightState
        
        startDebounceTask(delay: trafficLightState.duration) { [weak self] in
            self?.trafficLightState = nextState
            self?.transitionToNextState()
        }
    }
    
    // MARK: - Public
    func trafficLightColorOpacity(for light: TrafficLight) -> Double {
        guard isDriving else { return 0.5 }
        
        switch light {
        case .green:
            return trafficLightState == .go ? 1.0 : 0.5
        case .orange:
            let isActive = trafficLightState == .stopIfSafe || trafficLightState == .getReady
            return isActive ? 1.0 : 0.5
        case .red:
            let isActive = trafficLightState == .stop || trafficLightState == .getReady
            return isActive ? 1.0 : 0.5
        }
    }
    
    func userDidTapActionButton() {
        withAnimation {
            isDriving.toggle()
            trafficLightState = .go
        }
        
        isDriving ? transitionToNextState() : cancelDebounceTask()
    }
}
