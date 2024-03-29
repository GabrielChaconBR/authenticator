//
//  ContentView.swift
//  Authenticator
//
//  Created by Gabriel Chacon on 29/03/24.
//

import SwiftUI
import CoreData
import Combine
import ComposableArchitecture

// MARK: - Login State
struct LoginState: Equatable {
    var agency: String = ""
    var accountNumber: String = ""
    var electronicPassword: String = ""
    var isPreLoginButtonDisabled = true
    var isLoginButtonVisible = false
    var isValidationVisible = false
}

// MARK: - Login Actions
enum LoginAction: Equatable {
    case agencyChanged(String)
    case accountNumberChanged(String)
    case electronicPasswordChanged(String)
    case preLogin
    case login
    case forgotPassword
}

// MARK: - Environment
struct LoginEnvironment {
    var preLogin: () -> Effect<Void, Never>
    var login: (String, String, String) -> Effect<Void, Never>
    var forgotPassword: () -> Effect<Void, Never>
}

// MARK: - Login Reducer
let loginReducer = Reducer<LoginState, LoginAction, LoginEnvironment> { state, action, environment in
    switch action {
    case .agencyChanged(let agency):
        state.agency = agency
        return .none
        
    case .accountNumberChanged(let number):
        state.accountNumber = number
        state.isValidationVisible = number.count == 6
        if state.isValidationVisible {
            return environment.preLogin()
        }
        return .none
        
    case .electronicPasswordChanged(let password):
        state.electronicPassword = password
        state.isLoginButtonVisible = password.count > 5
        return .none
        
    case .preLogin:
        // Implement pre-login behavior
        return .none
        
    case .login:
        // Call the login network request with the current state values
        return environment.login(state.agency, state.accountNumber, state.electronicPassword)
        
    case .forgotPassword:
        // Call the forgot password network request
        return environment.forgotPassword()
    }
}

// MARK: - Login View
struct LoginView: View {
    let store: Store<LoginState, LoginAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                // Logo
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                
                // Input Fields
                HStack {
                    TextField("Agência", text: viewStore.binding(
                        get: { $0.agency },
                        send: LoginAction.agencyChanged))
                    .keyboardType(.numberPad)
                    .frame(maxWidth: .infinity)
                    
                    TextField("Conta Corrente", text: viewStore.binding(
                        get: { $0.accountNumber },
                        send: LoginAction.accountNumberChanged))
                    .keyboardType(.numberPad)
                    .frame(maxWidth: .infinity)
                }
                
                TextField("Senha Eletrônica", text: viewStore.binding(
                    get: { $0.electronicPassword },
                    send: LoginAction.electronicPasswordChanged))
                
                // Buttons
                if viewStore.isLoginButtonVisible {
                    Button("Entrar", action: { viewStore.send(.login) })
                }
                
                Button("Esqueci a Senha", action: { viewStore.send(.forgotPassword) })
                    .disabled(viewStore.isPreLoginButtonDisabled)
                
                // Validation Component
                if viewStore.isValidationVisible {
                    ValidationView()
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

// MARK: - Validation View
struct ValidationView: View {
    var body: some View {
        HStack {
            Text("Validando")
            ProgressView()
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

// MARK: - Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(store: Store(
            initialState: LoginState(),
            reducer: loginReducer,
            environment: LoginEnvironment(
                preLogin: { .none },
                login: { _, _, _ in .none },
                forgotPassword: { .none }
            )
        ))
    }
}

// MARK: - Unit Tests
// You would then write unit tests for each aspect of the UI and logic, ensuring actions update the state as expected.



#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
