//
//  LoginUnificadoView.swift
//  Authenticator
//
//  Created by Gabriel Chacon on 29/03/24.
//

import SwiftUI

struct LoginUnificadoView: View {
    
    @ObservedObject var viewModel = LoginUnificadoViewModel()
    
    private enum Metrics {
        static let heightLogo: CGFloat = 35
        static let widthLogo: CGFloat = 35
        static let paddingTopLogo: CGFloat = 16
        static let paddingLeadingLogo: CGFloat = 16
    }
    
    var logo: String = "logo"
    var blackArrow: String = "arrow_right_gray"
    var whiteArrow: String = "arrow_right_white"
    var agencyTitle: String = "Agência"
    var accountTitle: String = "Conta Corrente"
    var enterTitle: String = "Entrar"
    var passwordTitle: String = "Senha Eletrônica"
    var forgotPasswordTitle: String = "Esqueci a Senha"
    var validateTitle: String = "Validando..."
    
    var body: some View {
        VStack {
            HStack {
                Image(logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: Metrics.widthLogo, height: Metrics.heightLogo)
                    .padding(.top, Metrics.paddingTopLogo)
                    .padding(.leading, Metrics.paddingLeadingLogo)
                    .alignmentGuide(.leading) { d in d[.leading] }
                Spacer()
            }
            HStack {
                MDTextFieldView(label: agencyTitle, text: $viewModel.agency)
                    .frame(maxWidth: .infinity)
                    .keyboardType(.numberPad)
                
                MDTextFieldView(label: accountTitle, text: $viewModel.account)
                    .frame(maxWidth: .infinity)
                    .keyboardType(.numberPad)
            }
            .padding()
            
            MDTextFieldView(label: passwordTitle, text: $viewModel.password, secure: true)
                .frame(maxWidth: .infinity)
                .keyboardType(.numberPad)
                .padding()
            
            Spacer() 
            
            ZStack {
                if viewModel.showEnterButton {
                    ButtonView(title: enterTitle, icon: whiteArrow,
                               clickTap: {
                        // Chamar método de login
                    })
                }
                
                ButtonView(title: forgotPasswordTitle, titleColor: .gray, color: .clear, icon: blackArrow,
                           clickTap: {
                    // Chamar método de login
                })
                .disabled(!viewModel.showEsqueciSenhaButton)
                
                if viewModel.isPreLoginDone {
                    ValidateLoadingView(validateTitle: validateTitle)
                        .padding(.bottom)
                    
                }
            }
        }.padding(.top, 64)
    }
}

#Preview {
    LoginUnificadoView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
