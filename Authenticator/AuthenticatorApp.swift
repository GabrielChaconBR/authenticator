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
            LoginUnificadoView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
