//
//  RandomUserResponse.swift
//  Coordinator
//
//  Created by Евгений Самарин on 17.12.2021.
//

import Foundation

struct RandomUserResponse: Codable {

    // MARK: - Instance Properties

    let gender: String?
    let name: Name?

    private enum CodingKeys : String, CodingKey {
        case name = "name", gender = "gender"
    }
}
