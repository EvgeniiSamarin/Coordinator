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
    private let userService = UserService()

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Instance Methods

    func start() {
        let isAuthorized = userService.isUserAuth
        isAuthorized ? showMainFlow() : showStartFlow()
    }

    private func showStartFlow() {
        let startCoordinator = StartCoordinator(navigationController: navigationController, userService: userService)
        childCoordinators.append(startCoordinator)
        startCoordinator.flowCompletionHandler = { [weak self] in
            guard let self = self else { return }
            self.childCoordinators.removeAll { $0 === startCoordinator }
            self.userService.isUserAuth = true
            self.showMainFlow()
        }
        startCoordinator.start()
    }

    private func showMainFlow() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController, userService: userService)
        childCoordinators.append(mainCoordinator)
        mainCoordinator.flowCompletionHandler = { [weak self] in
            guard let self = self else { return }
            self.childCoordinators.removeAll { $0 === mainCoordinator }
            self.userService.isUserAuth = false
            self.showStartFlow()
        }
        mainCoordinator.start()
    }
}
