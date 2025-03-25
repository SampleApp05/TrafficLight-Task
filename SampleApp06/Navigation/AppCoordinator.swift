//
//  AppCoordinator.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 22.03.25.
//

import SwiftUI

enum AppFlow: Hashable {
    case action(modelName: String)
    // Could have more cases like maintanece, app update, no connection etc
}

@Observable
final class AppCoordinator: Coordinator {
    let container: (any Coordinator)? = nil
    var childContainer: (any Coordinator)?
    
    var path: [AppFlow] = []
    
    var rootView: AnyView {
        let viewModel = CarInputViewModel(coordinator: self)
        return CarInputView(viewModel: viewModel).asAnyView
    }
    
    func content(for flow: AppFlow) -> AnyView {
        switch flow {
        case let .action(modelName):
            let viewModel = TrafficLightViewModel(coordinator: self, carModelName: modelName)
            return TrafficLightView(viewModel: viewModel).asAnyView
        }
    }
}
