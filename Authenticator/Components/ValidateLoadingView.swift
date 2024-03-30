//
//  ValidateLoadingView.swift
//  Authenticator
//
//  Created by Gabriel Chacon on 30/03/24.
//

import SwiftUI

struct ValidateLoadingView: View {

    private enum Metrics {
        static let loadingWidth: CGFloat = 25
        static let loadingHeight: CGFloat = 25
        static let padding: CGFloat = 32
        static let height: CGFloat = 75
    }

    private let validateTitle: String
    private let width: CGFloat
    private let height: CGFloat
    private let color: Color
    
    internal init(validateTitle: String, width: CGFloat = .infinity, height: CGFloat = Metrics.height, color: Color = .darkGreen) {
        self.validateTitle = validateTitle
        self.width = width
        self.height = height
        self.color = color
    }
    
    var body: some View {
        HStack {
            HStack {
                Text(validateTitle)
                    .foregroundColor(.white)
                Spacer()
                LoadingView(color: .white, width: Metrics.loadingWidth, height: Metrics.loadingHeight)
            }.padding(EdgeInsets(top: .zero, leading: Metrics.padding, bottom: .zero, trailing: Metrics.padding))
        }
        .frame(maxWidth: width, maxHeight: height)
        .background(color)
    }
}

#Preview {
    ValidateLoadingView(validateTitle: "Validando...")
}
