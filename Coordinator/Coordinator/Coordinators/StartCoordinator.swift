//
//  StartCoordinator.swift
//  Coordinator
//
//  Created by Евгений Самарин on 17.12.2021.
//

import UIKit

enum SelectedStartFlow {

    // MARK: - Enumeration Cases

    case main
    case forgotPassword
}

final class StartCoordinator: Coordinator {

    // MARK: - Instance Properties

    var navigationController: UINavigationController
    var flowCompletionHandler: CoordinatorHandler?

    //MARK: -

    private var childCoordinators: [Coordinator] = []
    private let userService: UserService

    //MARK: - Initializer

    init(navigationController: UINavigationController, userService: UserService) {
        self.navigationController = navigationController
        self.userService = userService
    }

    // MARK: - Instance Methods

    func start() {
        let vc = StartViewController()
        vc.completionHandler = { [weak self] selectedFlow in
            switch selectedFlow {
            case .main:
                self?.flowCompletionHandler?()

            case .forgotPassword:
                self?.showForgotPasswordFlow()
            }
        }
        
        navigationController.setViewControllers([vc], animated: true)
    }

    func showForgotPasswordFlow() {
        let registrationCoordinator = RegistrationCoordinator(
            navigationController: navigationController,
            userService: userService
        )
        childCoordinators.append(registrationCoordinator)
        registrationCoordinator.flowCompletionHandler = { [weak self] in
            self?.childCoordinators.removeAll()
            self?.flowCompletionHandler?()
        }
        registrationCoordinator.start()
    }
}

