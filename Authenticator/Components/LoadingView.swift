//
//  LoadingView.swift
//  Authenticator
//
//  Created by Gabriel Chacon on 30/03/24.
//

import SwiftUI

struct LoadingView: View {
    
    private enum Metrics {
        static let trimTo: CGFloat = 0.6
        static let lineWidth: CGFloat = 3
        static let degrees: CGFloat = 360
        static let one: CGFloat = 1
    }

    @State private var isAnimating: Bool = true
    private var color: Color
    private var width: CGFloat
    private var height: CGFloat
    
    internal init(color: Color, width: CGFloat, height: CGFloat) {
        self.color = color
        self.width = width
        self.height = height
    }
    
    var body: some View {
        Circle()
            .trim(from: .zero, to: Metrics.trimTo)
            .stroke(color, lineWidth: Metrics.lineWidth)
            .frame(width: width, height: height)
            .rotationEffect(Angle(degrees: isAnimating ? Metrics.degrees : .zero))
            .animation(Animation.linear(duration: Metrics.one).repeatForever(autoreverses: false), value: isAnimating)
            .onAppear() {
                self.isAnimating = false
            }
            .onDisappear() {
                self.isAnimating = true
            }
    }
}

struct CustomLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(color: .white, width: 35, height: 35)
            .background(.darkGreen)
    }
}
