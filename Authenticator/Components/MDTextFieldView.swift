//
//  LoginTextFieldView.swift
//  Authenticator
//
//  Created by Gabriel Chacon on 30/03/24.
//

import SwiftUI
import Combine

struct MDTextFieldView: View {

    private enum Metrics {
        static let eight: CGFloat = 8
        static let ten: CGFloat = 25
        static let zeroDotEight: CGFloat = 0.8
        static let minusTwenty: CGFloat = 0
        static let one: CGFloat = 1
        static let retangleHeight: CGFloat = 1
        static let viewPaddingTop: CGFloat = 15
    }
    
    @Binding private var text: String
    @State private var focused: Bool = false
    @FocusState private var isFocused: Bool
    private var label: String
    private var lineColor: Color
    private var secure: Bool
    private let mask: Mask?
    
    internal init(label: String, text: Binding<String>, lineColor: Color = .gray, secure: Bool = false, mask: Mask? = nil) {
        self._text = text
        self.label = label
        self.lineColor = lineColor
        self.secure = secure
        self.mask = mask
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Metrics.eight) {
            Text(label)
                .font(.caption)
                .foregroundColor(lineColor)
                .offset(y: isFocused || !text.isEmpty ? Metrics.minusTwenty : Metrics.ten)
                .scaleEffect(isFocused || !text.isEmpty ? Metrics.zeroDotEight : Metrics.one, anchor: .leading)

            if secure {
                SecureField(String(), text: $text)
                    .focused($isFocused)
                    .foregroundColor(.black)
            } else {
                TextField(String(), text: $text, onEditingChanged: { edit in
                    self.focused = edit
                })
                .onReceive(Just(text), perform: { text in
                    self.text = mask?.formateValue(text) ?? text
                })
                    .focused($isFocused)
                    .foregroundColor(.black)
            }

            Rectangle()
                .frame(height: Metrics.retangleHeight)
                .foregroundColor(isFocused ? lineColor : .gray)
        }
        .padding(.top, Metrics.viewPaddingTop)
        .animation(.easeInOut, value: isFocused)
        .onTapGesture {
            self.isFocused = true
        }.foregroundColor(.gray)
    }
}

struct ContentView: View {
    @State private var text: String = String()

    var body: some View {
        VStack {
            MDTextFieldView(label: "Exemplo", text: $text)
                .padding()
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
