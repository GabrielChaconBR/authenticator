//
//  AuthenticatorApp.swift
//  Authenticator
//
//  Created by Gabriel Chacon on 29/03/24.
//

import SwiftUI

@main
struct AuthenticatorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LoginUnificadoView(entity: LoginUnificadoViewEntity(logo: "logo", iconTextFieldPrimary: "arrow_right_gray", iconTextFieldSecundary: "arrow_right_white", agencyTitle: "Agência", accountTitle: "Conta Corrente", enterTitle: "Entrar", passwordTitle: "Senha Eletrônica", forgotPasswordTitle: "Esqueci a Senha", validateTitle: "Validando...", agencyMask: DataMask(maskFormat: "####"), accountMask: DataMask(maskFormat: "#####-#")))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
