//
//  CarInputViewModelTests.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 24.03.25.
//

import Testing
@testable import SampleApp06

struct CarInputViewModelTests {
    private let coordinator: AppCoordinator
    private let viewModel: CarInputViewModel
    
    init() {
        coordinator = AppCoordinator()
        viewModel = CarInputViewModel(coordinator: coordinator)
    }
    
    @Test
    func testValidInput() async throws {
        viewModel.carModel.modelName = "Very fast car"
        viewModel.validate()
        
        try await Task.sleep(nanoseconds: 0.5.inNanoSeconds)
        #expect(viewModel.shouldShowErrorMessage == false, "The error message should not be shown.")
        #expect(viewModel.canProceed, "Proceed should be enabled.")
    }
    
    @Test
    func testInvalidInput() async throws {
        viewModel.carModel.modelName = "jk"
        viewModel.validate()
        
        try await Task.sleep(nanoseconds: 0.5.inNanoSeconds)
        #expect(viewModel.shouldShowErrorMessage, "The error message should be shown.")
        #expect(viewModel.canProceed == false, "Proceed should be not enabled.")
    }
    
    @Test
    func testProceedNavigation() async throws {
        viewModel.carModel.modelName = "Very fast car"
        viewModel.proceed()
        
        let coordinatorPath = viewModel.coordinator?.path
        
        #expect(coordinatorPath != nil, "Coordinator should be alive")
        #expect(coordinatorPath!.count == 1, "Coordinator path should be exactly 1 element long")
        #expect(coordinatorPath![0] == .action(modelName: viewModel.carModel.modelName), "Path should contain correct action")
    }
}
