//
//  LoginUnificadoViewModel.swift
//  Authenticator
//
//  Created by Gabriel Chacon on 29/03/24.
//

import Foundation
import Combine

class LoginUnificadoViewModel: ObservableObject, loginUnificadoViewModelProtocol {
    
    enum FocusState {
            case agency, currentAccount
        }
    
    @Published var agency: String = String()
    
    @Published var currentAccount: String = String()
    
    @Published var password: String = String()
    
    @Published var focusState: FocusState? = .agency
    @Published var isPreLoginDone: Bool = false
    @Published var showEnterButton: Bool = false
    @Published var showEsqueciSenhaButton: Bool = true
    
    var changeFocusToAccount = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $agency
            .sink { [weak self] agency in
                if agency.count == 4 {
                    self?.changeFocusToAccount.send()
                }
            }
            .store(in: &cancellables)
        
        $password
            .map { $0.count > 5 }
            .assign(to: &$showEnterButton)
        
        $currentAccount
            .map { $0.count == 7 }
            .assign(to: &$isPreLoginDone)
        
        $currentAccount
            .dropFirst(4)
            .sink { [weak self] account in
                if account.count == 7 {
                    self?.preLogin()
                }
            }
            .store(in: &cancellables)
    }
    
    
    
    func preLogin() {
        
        simulateNetworkRequest {
            // Este bloco é executado após a "requisição de rede" ser concluída
            print("Callback chamado após a conclusão da requisição de pre-login.")
            self.isPreLoginDone = false
        }
    }
    
    func login() {

        simulateNetworkRequest {
            // Este bloco é executado após a "requisição de rede" ser concluída
            print("Callback chamado após a conclusão da requisição de login.")
        }
    }
    
    func forgotPassword() {
        
    }
    
    func simulateNetworkRequest(completion: @escaping () -> Void) {
        print("Início da requisição de rede simulada...")
        
        // Executa o bloco de código depois de um delay de 5 segundos
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("Requisição de rede simulada concluída.")
            
            // Chama o completion handler para notificar que a requisição foi concluída
            completion()
        }
    }
}

