//
//  APIManager.swift
//  Coordinator
//
//  Created by Евгений Самарин on 17.12.2021.
//

import Foundation
import Combine

final class APIManager {

    // MARK: -

    static let shared = APIManager()

    // MARK: - Instance Methods

    func getRandomCatFact() -> AnyPublisher<RandomUserResponse, Error> {
        let request: URLRequest = .getRandomUserInfo()

        return URLSession.shared.fetch(for: request)
    }
}

