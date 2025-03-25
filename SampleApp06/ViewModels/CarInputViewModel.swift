//
//  CarInputViewModel.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 22.03.25.
//

import SwiftUI

@Observable
final class CarInputViewModel: Debouncer, CoordinatorViewModel {
    private(set) weak var coordinator: AppCoordinator?
    var carModel: CarModel = .init() // would need to be passed and persisted  on a higher level if we want to keep the data between views
    
    private(set) var canProceed: Bool = false
    private(set) var shouldShowErrorMessage: Bool = false
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Private
    private func validateInput() {
        canProceed = carModel.modelName.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3
    }
    
    // MARK: - Public
    func validate() {
        startDebounceTask(delay: 0.35) { [weak self] in
            self?.validateInput()
            self?.shouldShowErrorMessage = self?.canProceed == false
        }
    }
    
    func proceed() {
        navigate(to: .action(modelName: carModel.modelName))
    }
}
