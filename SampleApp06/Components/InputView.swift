//
//  InputView.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 23.03.25.
//

import SwiftUI

typealias VoidClosure = () -> Void

struct InputView: View {
    struct Style {
        let foreground: AnyShapeStyle
        let radius: Double
        let background: AnyShapeStyle
        let border: AnyShapeStyle
        let borderWidth: CGFloat
        
        static let primary = Style(
            foreground: .init(.black),
            radius: 20,
            background: .init(.thinMaterial),
            border: .init(Color.accentColor.opacity(0.5)),
            borderWidth: 2
        )
    }
    
    private let placeholder: String
    @Binding private var input: String
    private let style: Style
    private let onInputChanged: VoidClosure?

    init(
        placeholder: String,
        input: Binding<String>,
        style: Style = .primary,
        onInputChanged: VoidClosure? = nil
    ) {
        self.placeholder = placeholder
        self._input = input
        self.style = style
        self.onInputChanged = onInputChanged
    }

    var body: some View {
        TextField(placeholder, text: $input)
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(style.background)
            .bordered(
                radius: style.radius,
                style: .init(style.border),
                lineWidth: style.borderWidth
            )
            .onChange(of: input) {
                onInputChanged?()
            }
    }
}

#Preview {
    StatePreviewWrapper(state: "") { (input) in
        InputView(placeholder: "Placeholder", input: input)
    }
}
