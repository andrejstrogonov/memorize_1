//
//  GradientButtonStyle.swift
//  Memorize_1
//
//  Created by xcode on 16.01.2021.
//  Copyright © 2021 test. All rights reserved.
//

import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    
    var color: Color = Color.red
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [color, color.opacity(0.75), color.opacity(0.5)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

