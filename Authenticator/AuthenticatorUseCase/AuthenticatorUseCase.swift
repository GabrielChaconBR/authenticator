//
// 
//  AuthenticatorUseCase.swift
//  Authenticator
//
//  Created by Gabriel Chacon on 31/03/24.
//
//

import Foundation
import Domain
import Combine

public class AuthenticatorUseCase {
    
    public typealias UseCaseEvent = Result<AuthenticatorUseCaseResponse, MessageError>
    private let service: ServiceAuthHubProtocol
    private var cancellables = Set<AnyCancellable>()
    
    public init(service: ServiceAuthHubProtocol) {
        self.service = service
    }
}

extension AuthenticatorUseCaseUseCase: AuthenticatorUseCaseProtocol {
    
    public func execute() -> AnyPublisher<UseCaseEvent, Error> {
        Future<UseCaseEvent, Error> { [weak self] promise in
            // TO-DO: Implement self?.service.method
            // For example, if your service method completion handler returns success or failure:
            // self?.service.method { result in
            //     switch result {
            //     case .success(let data):
            //         promise(.success(data))
            //     case .failure(let error):
            //         promise(.failure(error))
            //     }
            // }
        }
        .eraseToAnyPublisher()
    }
}
