//
//  ScrollableModifier.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 23.03.25.
//

import SwiftUI

struct ScrollableModifier: ViewModifier {
    private let axes: Axis.Set
    private let indicatorVisibility: ScrollIndicatorVisibility
    private let bounceBehaviour: ScrollBounceBehavior
    private let scrollClipDisabled: Bool
    
    init(
        _ axes: Axis.Set,
        indicatorVisibility: ScrollIndicatorVisibility,
        bounceBehaviour: ScrollBounceBehavior,
        scrollClipDisabled: Bool
    ) {
        self.axes = axes
        self.indicatorVisibility = indicatorVisibility
        self.bounceBehaviour = bounceBehaviour
        self.scrollClipDisabled = scrollClipDisabled
    }
    
    func body(content: Content) -> some View {
        ScrollView(axes) {
            content
        }
        .scrollIndicators(indicatorVisibility)
        .scrollBounceBehavior(bounceBehaviour, axes: axes)
        .scrollClipDisabled(scrollClipDisabled)
        .clipped()
    }
}
