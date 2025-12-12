//
//  Styles.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-12-12.
//
import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    var normalColor: Color
    var pressedColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? pressedColor : normalColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}
