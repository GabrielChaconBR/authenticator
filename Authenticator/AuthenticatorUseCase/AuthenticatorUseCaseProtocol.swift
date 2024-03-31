//
// 
//  AuthenticatorUseCaseProtocol.swift
//  Authenticator
//
//  Created by Gabriel Chacon on 31/03/24.
//
//

import Domain
import Combine
import Foundation

public protocol AuthenticatorUseCaseProtocol: AnyObject {
    func execute() -> AnyPublisher<Result<AuthenticatorUseCaseResponse, MessageError>, Never>
}
