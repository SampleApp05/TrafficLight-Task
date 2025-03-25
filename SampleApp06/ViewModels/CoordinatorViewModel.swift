//
//  CoordinatorViewModel.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 22.03.25.
//

import Foundation

protocol CoordinatorViewModel: AnyObject, Observable {
    associatedtype T: Coordinator
    var coordinator: T? { get }
    
    func navigate(to flow: T.Flow, shouldOverride: Bool)
    func goBack()
    func reset()
}

extension CoordinatorViewModel {
    func navigate(to flow: T.Flow, shouldOverride: Bool = false) {
        coordinator?.navigate(to: flow, shouldOverride: shouldOverride)
    }
    
    func goBack() {
        coordinator?.goBack()
    }
    
    func reset() {
        coordinator?.reset()
    }
}
