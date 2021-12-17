//
//  AppCoordinator.swift
//  Coordinator
//
//  Created by Евгений Самарин on 17.12.2021.
//

import UIKit

class AppCoordinator: Coordinator {

    // MARK: - Instance Properties

    var navigationController: UINavigationController
    var flowCompletionHandler: CoordinatorHandler?

    // MARK: -

    private var childCoordinators: [Coordinator] = []
    // TODO: - UserService

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Instance Methods

    func start() {
        // TODO: - Check Auth User
        self.showStartFlow()
    }

    private func showStartFlow() {
        let startCoordinator = StartCoordinator(navigationController: navigationController)
        childCoordinators.append(startCoordinator)
        startCoordinator.flowCompletionHandler = { [weak self] in
            guard let self = self else { return }
            self.childCoordinators.removeAll { $0 === startCoordinator }
            self.showMainFlow()
        }
        startCoordinator.start()
    }

    private func showMainFlow() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        childCoordinators.append(mainCoordinator)
        mainCoordinator.flowCompletionHandler = { [weak self] in
            guard let self = self else { return }
            self.childCoordinators.removeAll { $0 === mainCoordinator }
            self.showStartFlow()
        }
        mainCoordinator.start()
    }
}
