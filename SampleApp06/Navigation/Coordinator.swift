//
//  Coordinator.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 22.03.25.
//

import SwiftUI

// Would need to be extended/tweaked for more complex scenarios
protocol Coordinator: AnyObject, Observable {
    associatedtype Flow: Hashable
    
    var path: [Flow] { get set }
    
    var view: AnyView { get }
    var rootView: AnyView { get }
    
    func start(with stack: [Flow])
    func navigate(to flow: Flow, shouldOverride: Bool)
    func goBack()
    func reset()
    
    func content(for flow: Flow) -> AnyView
}

extension Coordinator {
    var view: AnyView { CoordinatorRootView(coordinator: self).asAnyView }
    
    func start(with stack: [Flow]) {
        path = stack
    }
    
    func navigate(to flow: Flow, shouldOverride: Bool = false) {
        shouldOverride ? path = [flow] : path.append(flow)
    }
    
    func goBack() {
        _ = path.popLast()
    }
    
    func reset() {
        path = []
    }
}
