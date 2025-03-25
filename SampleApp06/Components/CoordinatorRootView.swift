//
//  CoordinatorRootView.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 22.03.25.
//

import SwiftUI

struct CoordinatorRootView<T: Coordinator>: View where T: Observable {
    private let coordinator: T
    
    init(coordinator: T) {
        self.coordinator = coordinator
    }
        
    var body: some View {
        @Bindable var coordinator = coordinator
        
        NavigationStack(path: $coordinator.path) {
            coordinator.rootView
                .navigationDestination(for: T.Flow.self) { (flow) in
                    coordinator.content(for: flow)
                }
        }
    }
}

#Preview {
    CoordinatorRootView(coordinator: AppCoordinator())
}
