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
    // TODO: - User Service

    //MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Instance Methods

    func start() {
        let vc = StartViewController()
        vc.completionHandler = { [weak self] selectedFlow in
            switch selectedFlow {
            case .main:
                self?.showMainFlow()
            case .forgotPassword:
                self?.showForgotPasswordFlow()
            }
        }
        
        navigationController.setViewControllers([vc], animated: true)
    }

    func showMainFlow() {
        // TODO: - Main Coordinator
    }

    func showForgotPasswordFlow() {
        let registrationCoordinator = RegistrationCoordinator(
            navigationController: navigationController
        )
        childCoordinators.append(registrationCoordinator)
        registrationCoordinator.flowCompletionHandler = { [weak self] in
            self?.childCoordinators.removeAll()
            self?.flowCompletionHandler?()
        }
        registrationCoordinator.start()
    }
}

