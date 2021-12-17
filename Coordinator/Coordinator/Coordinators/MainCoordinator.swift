//
//  MainCoordinator.swift
//  Coordinator
//
//  Created by Евгений Самарин on 17.12.2021.
//

import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var flowCompletionHandler: CoordinatorHandler?

    private var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        // TODO: -
    }
}
