//
//  Results.swift
//  Coordinator
//
//  Created by Евгений Самарин on 17.12.2021.
//

import Foundation

struct Results: Codable {

    // MARK: - Instance Properties

    let results: RandomUserResponse?

    private enum CodingKeys : String, CodingKey {
        case results = "results"
    }
}
