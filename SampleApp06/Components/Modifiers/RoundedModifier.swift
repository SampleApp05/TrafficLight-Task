//
//  RoundedModifier.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 23.03.25.
//

import SwiftUI

struct RoundedModifier: ViewModifier {
    private let radius: Double
    
    init(radius: Double) {
        self.radius = radius
    }
    
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: radius))
    }
}
