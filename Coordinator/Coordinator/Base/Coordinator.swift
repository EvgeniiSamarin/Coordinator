//
//  Coordinator.swift
//  Coordinator
//
//  Created by Евгений Самарин on 17.12.2021.
//

import UIKit

typealias CoordinatorHandler = () -> Void

protocol Coordinator: AnyObject {

    // MARK: - Instance Properties

    var navigationController: UINavigationController { get set }
    var flowCompletionHandler: CoordinatorHandler? { get set }

    // MARK: - Instance Methods

    func start()
}
