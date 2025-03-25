//
//  SampleApp06App.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 22.03.25.
//

import SwiftUI

@main
struct SampleApp06App: App {
    let appCoordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            appCoordinator.view
        }
    }
}
