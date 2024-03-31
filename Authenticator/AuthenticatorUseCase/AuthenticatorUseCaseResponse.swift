//
// 
//  AuthenticatorUseCaseResponse.swift
//  Authenticator
//
//  Created by Gabriel Chacon on 31/03/24.
//
//

import Foundation

public struct AuthenticatorUseCaseResponse: Codable {
    public let data: AuthenticatorUseCaseData?
}

public struct AuthenticatorUseCaseData: Codable {
    public let content: AuthenticatorUseCaseDataContent?
}

public struct AuthenticatorUseCaseDataContent: Codable {
    
}
