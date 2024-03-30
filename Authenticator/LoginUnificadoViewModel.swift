//
//  LoginUnificadoViewModel.swift
//  Authenticator
//
//  Created by Gabriel Chacon on 29/03/24.
//

import Foundation
import Combine

protocol loginUnificadoViewModelProtocol {
    
    var agency: String { get }
    var account: String { get }
    var password: String { get }
    var isPreLoginDone: Bool { get }
    var showEnterButton: Bool { get }
    var showEsqueciSenhaButton: Bool { get }
    
    func preLogin()
    func login()
    func forgotPassword()
}

class LoginUnificadoViewModel: ObservableObject, loginUnificadoViewModelProtocol {
    
    @Published var agency: String = String()
    @Published var account: String = String()
    @Published var password: String = String()
    @Published var isPreLoginDone: Bool = false
    @Published var showEnterButton: Bool = true
    @Published var showEsqueciSenhaButton: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $password
            .map { $0.count > 5 }
            .assign(to: &$showEnterButton)
        
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
    
    func login() {
        
    }
    
    func forgotPassword() {
        
    }
}

