//
//  LoginUnificadoViewModel.swift
//  Authenticator
//
//  Created by Gabriel Chacon on 29/03/24.
//

import Foundation
import Combine

class LoginUnificadoViewModel: ObservableObject {
    
    @Published var agency: String = String()
    @Published var account: String = String()
    @Published var password: String = String()
    @Published var isPreLoginDone = false
    @Published var showLoginButton = false
    @Published var showEsqueciSenhaButton = true
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $password
            .map { $0.count > 5 }
            .assign(to: &$showLoginButton)
        
        $account
            .map { $0.count == 5 }
            .assign(to: &$isPreLoginDone)
        
        $account
            .dropFirst(4)
            .sink { [weak self] conta in
                if conta.count == 5 {
                    self?.preLogin()
                }
            }
            .store(in: &cancellables)
    }
    
    func preLogin() {
        // Implementar a lógica de pré-login aqui, altera `isPreLoginDone`
    }
}

