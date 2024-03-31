//
//  LoginUnificadoProtocol.swift
//  Authenticator
//
//  Created by Gabriel Chacon on 31/03/24.
//

import Foundation
import Combine

protocol loginUnificadoViewModelProtocol {
    
    var agency: String { get }
    var currentAccount: String { get }
    var password: String { get }
    var isPreLoginDone: Bool { get }
    var showEnterButton: Bool { get }
    var showEsqueciSenhaButton: Bool { get }
    var changeFocusToAccount: PassthroughSubject<Void, Never> { get set }
    
    func preLogin()
    func login()
    func forgotPassword()
}
