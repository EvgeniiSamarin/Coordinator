//
//  FlowCoordinator.swift
//  Coordinator
//
//  Created by Евгений Самарин on 17.12.2021.
//

import Foundation

protocol FlowController {

    // MARK: - Associated Type

    associatedtype T

    // MARK: - Instance Properties

    var completionHandler: ((T) -> ())? { get set }
}

