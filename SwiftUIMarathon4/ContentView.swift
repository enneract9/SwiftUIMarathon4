//
//  ContentView.swift
//  SwiftUIMarathon4
//
//  Created by @_@ on 10.12.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Button("Play") {}
            .buttonStyle(.playNext)
            .frame(width: 60)
    }
}

extension ButtonStyle where Self == PlayNextButtonStyle {
    @MainActor @preconcurrency internal static var playNext: PlayNextButtonStyle { PlayNextButtonStyle() }
}

struct PlayNextButtonStyle: ButtonStyle {
    
    @State private var performLabelAnimation = false
    @State private var performBackgroundAnimation = false

    func makeBody(configuration: Configuration) -> some View {
        label()
            .background {
                background()
            }
            .scaleEffect(performBackgroundAnimation ? 0.86 : 1.0)
            .onChange(of: configuration.isPressed) {
                withAnimation(
                    .easeOut(duration: 0.22)
                ) {
                    performBackgroundAnimation.toggle()
                }
                
                if !performLabelAnimation && configuration.isPressed {
                    withAnimation(
                        Animation.spring(duration: 0.4, bounce: 0.3)
                    ) {
                        performLabelAnimation = true
                    } completion: {
                        performLabelAnimation = false
                    }
                }
            }
    }
    
    private func label() -> some View {
        GeometryReader { proxy in
            let width = proxy.size.width / 2
            
            HStack(alignment: .center, spacing: 0) {
                playImage()
                    .frame(width: performLabelAnimation ? width : .zero)
                    .opacity(performLabelAnimation ? 1 : .zero)
                playImage()
                    .frame(width: width)
                playImage()
                    .frame(width: performLabelAnimation ? 0.5 : width)
                    .opacity(performLabelAnimation ? .zero : 1)
            }
            .frame(maxHeight: .infinity, alignment: .center)
        }
    }
    
    private func playImage() -> some View {
        Image(systemName: "play.fill")
            .renderingMode (.template)
            .resizable()
            .scaledToFit()
    }
    
    private func background() -> some View {
        Circle()
            .padding(-16)
            .foregroundColor(.gray.opacity(performBackgroundAnimation ? 0.16 : .zero))
    }
}

#Preview {
    ContentView()
}
