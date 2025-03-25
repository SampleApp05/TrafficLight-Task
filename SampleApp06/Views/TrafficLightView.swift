//
//  TrafficLightView.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 25.03.25.
//

import SwiftUI

protocol TrafficLightViewHandler: AnyObject, Observable {
    var carModelName: String { get }
    var actionButtonTitle: String { get }
    
    func trafficLightColorOpacity(for light: TrafficLight) -> Double
    func userDidTapActionButton()
}

struct TrafficLightView: View {
    private let viewModel: TrafficLightViewHandler
    
    init(viewModel: TrafficLightViewHandler) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(viewModel.carModelName)
                .multilineTextAlignment(.center)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.horizontal, 50)
            
            Spacer()
            
            VStack {
                ForEach(TrafficLight.allCases, id: \.self) { light in
                    Circle()
                        .fill(light.color)
                        .frame(width: 100, height: 100)
                        .opacity(viewModel.trafficLightColorOpacity(for: light))
                        .animation(
                            .easeInOut,
                            value: viewModel.trafficLightColorOpacity(for: light)
                        )
                        
                }
            }
            .padding(15)
            .background(.thinMaterial)
            .bordered(
                radius: 20,
                style: .init(.ultraThickMaterial),
                lineWidth: 2
            )
            
            Spacer()
            
            Button {
                viewModel.userDidTapActionButton()
            } label: {
                Text(viewModel.actionButtonTitle)
                    .font(.callout)
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
            Spacer()
        }
        .navigationTitle("Drive")
    }
}

#Preview {
    let viewModel = TrafficLightViewModel(
        coordinator: AppCoordinator(),
        carModelName: "Model 3"
    )
    
    NavigationStack {
        TrafficLightView(viewModel: viewModel)
    }
}
