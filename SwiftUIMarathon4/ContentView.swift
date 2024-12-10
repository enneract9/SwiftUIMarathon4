//
//  ContentView.swift
//  SwiftUIMarathon4
//
//  Created by @_@ on 10.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var performAnimation = false

    var body: some View {
        Button {
            if !performAnimation {
                withAnimation(
                    Animation.spring(duration: 0.4, bounce: 0.3)
                ) {
                    performAnimation = true
                } completion: {
                    performAnimation = false
                }
            }
        } label: {
            GeometryReader { proxy in
                let width = proxy.size.width / 2
                let systemName = "play.fill"
                
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: systemName)
                        .renderingMode (.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: performAnimation ? width : .zero)
                        .opacity(performAnimation ? 1 : .zero)
                    Image(systemName: systemName)
                        .renderingMode (.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width)
                    Image(systemName: systemName)
                        .renderingMode (.template)
                        .resizable ()
                        .scaledToFit ()
                        .frame(width: performAnimation ? 0.5 : width)
                        .opacity(performAnimation ? .zero : 1)
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .frame(width: 60)
        .buttonStyle(PinokStyle())
    }
}

struct PinokStyle: ButtonStyle {
    
    @State private var performAnimation = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background {
                background()
            }
            .scaleEffect(performAnimation ? 0.86 : 1.0)
            .onChange(of: configuration.isPressed) {
                withAnimation(
                    .easeOut(duration: 0.22)
                ) {
                    performAnimation.toggle()
                }
            }
    }
    
    private func background() -> some View {
        Circle()
            .padding(-16)
            .foregroundColor(
                .gray.opacity(performAnimation ? 0.16 : .zero)
            )
    }
}

#Preview {
    ContentView()
}
