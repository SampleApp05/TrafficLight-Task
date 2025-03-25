//
//  TrafficLightViewModelTests.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 25.03.25.
//

import Testing
@testable import SampleApp06

struct TrafficLightViewModelTests {
    private let viewModel: TrafficLightViewModel
    
    init() {
        viewModel = TrafficLightViewModel(
            coordinator: .init(),
            carModelName: "Sample car model"
        )
    }
    
    @Test
    func testInitialState() async throws {
        assert(viewModel.isDriving == false, "Initial isDriving state should be false.")
        
        assert(viewModel.trafficLightState == .go, "The initial state should be go/green.")
        
        assert(viewModel.nextTrafficLightState == .stopIfSafe, "Next State should be stopIfSafe/orange.")
    }
    
    @Test
    func testChangeToStopState() async throws {
        viewModel.trafficLightState = .stopIfSafe
        assert(viewModel.nextTrafficLightState == .stop, "The next state should be stop/red.")
    }
    
    @Test
    func testChangeToGetReadyState() async throws {
        viewModel.trafficLightState = .stop
        assert(viewModel.nextTrafficLightState == .getReady, "The next state should be getReady/red+orange.")
    }
    
    @Test
    func testChangeToGoState() async throws {
        viewModel.trafficLightState = .getReady
        assert(viewModel.nextTrafficLightState == .go, "The next state should be go/green.")
    }
    
    @Test
    func testStartDriving() async throws {
        viewModel.userDidTapActionButton() // toggle isDriving var and start task
        
        assert(viewModel.isDriving == true, "The car should be driving.")
        assert(viewModel.debounceTask != nil, "The debouncer task should be started.")
    }
    
    @MainActor
    @Test
    func testStopDriving() async throws {
        viewModel.userDidTapActionButton() // toggle isDriving var and start task
        viewModel.userDidTapActionButton() // toggle isDriving var and cancel task
        
        assert(viewModel.isDriving == false, "The car should not be driving.")
        assert(viewModel.debounceTask == nil, "The debouncer task should be cancelled.")
        
        assert(viewModel.trafficLightState == .go, "The state should be reset to go/green.")
    }
}
