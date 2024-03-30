//
//  ButtonView.swift
//  Authenticator
//
//  Created by Gabriel Chacon on 30/03/24.
//

import SwiftUI

struct ButtonView: View {
    private enum Metrics {
        static let buttonPadding: CGFloat = 32
        static let linePadding: CGFloat = -10
        static let height: CGFloat = 75
        static let widthArrow: CGFloat = 20
        static let retangleHeight: CGFloat = 0.5
        static let heightArrow: CGFloat = 20
        static let witdh: CGFloat = .infinity
    }

    private let icon: String
    private let title: String
    private let titleColor: Color
    private let width: CGFloat
    private let height: CGFloat
    private let color: Color
    
    private let clickTap: (() -> Void)?
    
    internal init(title: String, titleColor: Color = .white, width: CGFloat = Metrics.witdh, height: CGFloat = Metrics.height, color: Color = .darkGreen, icon: String, clickTap: @escaping () -> Void) {
        self.title = title
        self.titleColor = titleColor
        self.width = width
        self.height = height
        self.color = color
        self.clickTap = clickTap
        self.icon = icon
    }
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: Metrics.retangleHeight)
                .foregroundColor(.gray)
            
            HStack {
                Button(action: {
                    clickTap?()
                }) {
                    HStack {
                        Text(title)
                            .foregroundColor(titleColor)
                        Spacer()
                        Image(icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: Metrics.widthArrow, height: Metrics.heightArrow)
                            .alignmentGuide(.leading) { d in d[.leading] }
                    }.padding(EdgeInsets(top: .zero, leading: Metrics.buttonPadding, bottom: .zero, trailing: Metrics.buttonPadding))
                }
                .frame(width: Metrics.witdh, height: Metrics.height)
            }
            .frame(maxWidth: width, maxHeight: height)
            .background(color)
            .padding(.top, Metrics.linePadding)
        }
    }
}

#Preview {
    VStack {
        ButtonView(title: "Entrar", icon: "arrow_right_white", clickTap: {})
        ButtonView(title: "Esqueci minha senha", titleColor: .gray, color: .clear, icon: "arrow_right_gray", clickTap: {})
    }
}
