//
//  View+Modifiers.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 23.03.25.
//

import SwiftUI

extension View {
    func rounded(radius: Double) -> some View {
        modifier(RoundedModifier(radius: radius))
    }
    
    func bordered(
        radius: Double,
        style: AnyShapeStyle,
        lineWidth: Double
    ) -> some View {
        modifier(
            BorderModifier(
                radius: radius,
                style: style,
                lineWidth: lineWidth
            )
        )
    }
    
    func scrollable(
        _ axes: Axis.Set = .vertical,
        indicatorVisibility: ScrollIndicatorVisibility = .hidden,
        bounceBehaviour: ScrollBounceBehavior = .basedOnSize,
        scrollClipDisabled: Bool = true
    ) -> some View{
        modifier(
            ScrollableModifier(
                axes,
                indicatorVisibility: indicatorVisibility,
                bounceBehaviour: bounceBehaviour,
                scrollClipDisabled: scrollClipDisabled
            )
        )
    }
}
