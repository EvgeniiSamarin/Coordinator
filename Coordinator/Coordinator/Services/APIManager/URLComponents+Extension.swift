//
//  URLComponents+Extension.swift
//  Coordinator
//
//  Created by Евгений Самарин on 17.12.2021.
//

import Foundation

public extension URLComponents {

    // MARK: - Initializer

    init(scheme: String = "https",
         host: String = "randomuser.me",
         path: String,
         queryItems: [URLQueryItem]? = nil) {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        self = components
    }
}

extension URLComponents {

    // MARK: - Instance methods

    static func user() -> Self {
        return Self(path: "/api/")
    }
}
