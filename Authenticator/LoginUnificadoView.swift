//
//  LoginUnificadoView.swift
//  Authenticator
//
//  Created by Gabriel Chacon on 29/03/24.
//

import SwiftUI

enum FocusField {
    case agency
    case currentAccount
}

struct LoginUnificadoViewEntity {
    let logo: String
    let iconTextFieldPrimary: String
    let iconTextFieldSecundary: String
    let agencyTitle: String
    let accountTitle: String
    let enterTitle: String
    let passwordTitle: String
    let forgotPasswordTitle: String
    let validateTitle: String
    let agencyMask: DataMask
    let accountMask: DataMask
}

struct LoginUnificadoView: View {
    
    private enum Metrics {
        static let heightLogo: CGFloat = 35
        static let widthLogo: CGFloat = 35
        static let paddingTopLogo: CGFloat = 16
        static let paddingLeadingLogo: CGFloat = 16
        static let padding: CGFloat = 64
    }
    
    @ObservedObject var viewModel = LoginUnificadoViewModel()
    //@FocusState private var focusField: FocusField?
    @FocusState private var focusedField: LoginUnificadoViewModel.FocusState?
    private let entity: LoginUnificadoViewEntity
    
    internal init(viewModel: LoginUnificadoViewModel = LoginUnificadoViewModel(), entity: LoginUnificadoViewEntity) {
        self.viewModel = viewModel
        self.entity = entity
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(entity.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: Metrics.widthLogo, height: Metrics.heightLogo)
                    .padding(.top, Metrics.paddingTopLogo)
                    .padding(.leading, Metrics.paddingLeadingLogo)
                    .alignmentGuide(.leading) { d in d[.leading] }
                Spacer()
            }
            HStack {
                MDTextFieldView(label: entity.agencyTitle, text: $viewModel.agency, mask: entity.agencyMask)
                    .frame(maxWidth: .infinity)
                    .keyboardType(.numberPad)
                    .focused($focusedField, equals: .agency)
                    .onTapGesture { viewModel.focusState = .agency }
                
                MDTextFieldView(label: entity.accountTitle, text: $viewModel.currentAccount, mask: entity.accountMask)
                    .frame(maxWidth: .infinity)
                    .keyboardType(.numberPad)
                    .focused($focusedField, equals: .currentAccount)
                    .onTapGesture { viewModel.focusState = .currentAccount }
            }
            .padding()
            
            MDTextFieldView(label: entity.passwordTitle, text: $viewModel.password, secure: true)
                .frame(maxWidth: .infinity)
                .keyboardType(.numberPad)
                .padding()
            
            Spacer()
            
            if viewModel.showEnterButton {
                ButtonView(title: entity.enterTitle, icon: entity.iconTextFieldSecundary,
                           clickTap: {
                    viewModel.login()
                })
            }
            
            ZStack {
                ButtonView(title: entity.forgotPasswordTitle, titleColor: .gray, color: .clear, icon: entity.iconTextFieldPrimary,
                           clickTap: {
                    viewModel.preLogin()
                })
                .disabled(!viewModel.showEsqueciSenhaButton)
                
                if viewModel.isPreLoginDone {
                    ValidateLoadingView(validateTitle: entity.validateTitle)
                        .padding(.bottom)
                    
                }
            }
        }
    }
}

#Preview {
    LoginUnificadoView(entity: LoginUnificadoViewEntity(logo: "logo", iconTextFieldPrimary: "arrow_right_gray", iconTextFieldSecundary: "arrow_right_white", agencyTitle: "Agência", accountTitle: "Conta Corrente", enterTitle: "Entrar", passwordTitle: "Senha Eletrônica", forgotPasswordTitle: "Esqueci a Senha", validateTitle: "Validando...", agencyMask: DataMask(maskFormat: "####"), accountMask: DataMask(maskFormat: "#####-#"))).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
