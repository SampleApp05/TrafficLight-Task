//
//  BorderModifier.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 23.03.25.
//

import SwiftUI

struct BorderModifier: ViewModifier {
    private let radius: Double
    private let style: AnyShapeStyle
    private let lineWidth: Double
    
    init(radius: Double, style: AnyShapeStyle, lineWidth: Double) {
        self.radius = radius
        self.style = style
        self.lineWidth = lineWidth
    }
    
    func body(content: Content) -> some View {
        content
            .rounded(radius: radius)
            .overlay {
                RoundedRectangle(cornerRadius: radius)
                    .strokeBorder(style, lineWidth: lineWidth)
            }
    }
}
