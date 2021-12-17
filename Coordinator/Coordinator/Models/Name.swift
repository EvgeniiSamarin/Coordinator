//
//  Name.swift
//  Coordinator
//
//  Created by Евгений Самарин on 17.12.2021.
//

import Foundation

struct Name: Codable {

    // MARK: - Instance properties

    let title: String?
    let first: String?
    let last: String?

    private enum CodingKeys : String, CodingKey {
        case title = "title", first = "first", last = "last"
    }
}
