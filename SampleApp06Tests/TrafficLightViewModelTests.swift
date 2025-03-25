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
        #expect(viewModel.isDriving == false, "Initial isDriving state should be false.")
        
        #expect(viewModel.trafficLightState == .go, "The initial state should be go/green.")
        
        #expect(viewModel.nextTrafficLightState == .stopIfSafe, "Next State should be stopIfSafe/orange.")
    }
    
    @Test
    func testChangeToStopState() async throws {
        viewModel.trafficLightState = .stopIfSafe
        #expect(viewModel.nextTrafficLightState == .stop, "The next state should be stop/red.")
    }
    
    @Test
    func testChangeToGetReadyState() async throws {
        viewModel.trafficLightState = .stop
        #expect(viewModel.nextTrafficLightState == .getReady, "The next state should be getReady/red+orange.")
    }
    
    @Test
    func testChangeToGoState() async throws {
        viewModel.trafficLightState = .getReady
        #expect(viewModel.nextTrafficLightState == .go, "The next state should be go/green.")
    }
    
    @Test
    func testStartDriving() async throws {
        viewModel.userDidTapActionButton() // toggle isDriving var and start task
        
        #expect(viewModel.isDriving == true, "The car should be driving.")
        #expect(viewModel.debounceTask != nil, "The debouncer task should be started.")
    }
    
    @Test
    func testStopDriving() async throws {
        viewModel.userDidTapActionButton() // toggle isDriving var and start task
        viewModel.userDidTapActionButton() // toggle isDriving var and cancel task
        
        #expect(viewModel.isDriving == false, "The car should not be driving.")
        #expect(viewModel.debounceTask == nil, "The debouncer task should be cancelled.")
        
        #expect(viewModel.trafficLightState == .go, "The state should be reset to go/green.")
    }
}
