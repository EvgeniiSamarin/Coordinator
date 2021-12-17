//
//  URLSession+Extension.swift
//  Coordinator
//
//  Created by Евгений Самарин on 17.12.2021.
//

import Foundation
import Combine

public extension URLSession {

    // MARK: - Instance Methods

    func fetch<Response: Decodable>(for request: URLRequest) -> AnyPublisher<Response, Error> {
        dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Response.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
