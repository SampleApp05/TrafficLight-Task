//
//  CarInputView.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 22.03.25.
//

import SwiftUI

struct CarInputView: View {
    @FocusState private var isFocused: Bool
    @Bindable private var viewModel: CarInputViewModel
    
    init(viewModel: CarInputViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 35) {
            Spacer()
            VStack(alignment: .leading, spacing: 5) {
                Text("Please enter the model of your car")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .padding(.leading, 5)
                    .multilineTextAlignment(.leading)
                
                InputView(
                    placeholder: "Car model",
                    input: $viewModel.carModel.modelName,
                    onInputChanged: viewModel.validate
                )
                .font(.headline)
                .fontWeight(.regular)
                .focusable()
                .focused($isFocused)
                
                if viewModel.shouldShowErrorMessage {
                    Text("Input must be at least 3 characters")
                        .foregroundColor(.red)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.leading, 20)
                        .multilineTextAlignment(.leading)
                        .transition(.opacity)
                }
            }
            
            Button {
                viewModel.proceed()
            } label: {
                Text("Drive to survive")
                    .font(.callout)
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.canProceed == false)
        }
        .scrollable()
        .simultaneousGesture(TapGesture().onEnded {
            isFocused = false
        })
        .padding(.horizontal, 20)
        .navigationTitle("Car Model Selection")
    }
}

#Preview {
    let viewModel = CarInputViewModel(
        coordinator: AppCoordinator()
    )
    CarInputView(viewModel: viewModel)
}
