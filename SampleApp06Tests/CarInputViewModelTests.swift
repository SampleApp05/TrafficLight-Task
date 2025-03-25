//
//  CarInputViewModelTests.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 24.03.25.
//

import Testing
@testable import SampleApp06

struct CarInputViewModelTests {
    private let viewModel: CarInputViewModel
    
    init() {
        viewModel = CarInputViewModel(coordinator: AppCoordinator())
    }
    
    @Test
    func testValidInput() async throws {
        viewModel.carModel.modelName = "Very fast car"
        viewModel.validate()
        
        try await Task.sleep(nanoseconds: 0.5.inNanoSeconds)
        assert(viewModel.shouldShowErrorMessage == false, "The error message should not be shown.")
        assert(viewModel.canProceed, "Proceed should be enabled.")
    }
    
    @Test
    func testInvalidInput() async throws {
        viewModel.carModel.modelName = "jk"
        viewModel.validate()
        
        try await Task.sleep(nanoseconds: 0.5.inNanoSeconds)
        assert(viewModel.shouldShowErrorMessage, "The error message should be shown.")
        assert(viewModel.canProceed == false, "Proceed should be not enabled.")
    }
}
