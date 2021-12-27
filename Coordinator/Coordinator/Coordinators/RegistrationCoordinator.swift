//
//  RegistrationCoordinator.swift
//  Coordinator
//
//  Created by Евгений Самарин on 17.12.2021.
//

import UIKit

final class RegistrationCoordinator: Coordinator {

    // MARK: - Instance Properties

    var navigationController: UINavigationController
    var flowCompletionHandler: CoordinatorHandler?

    // MARK: -

    private var childCoordinators: [Coordinator] = []
    private let userService: UserService

    private var user = User(login: "", password: "")

    // MARK: - Initializer

    init(navigationController: UINavigationController, userService: UserService) {
        self.navigationController = navigationController
        self.userService = userService
    }

    // MARK: - Instance Methods

    func start() {
        showEnterLoginFlow()
    }

    func showEnterLoginFlow() {
        let vc = LoginViewController()
        vc.completionHandler = { [weak self] login in
            self?.user.login = login
            self?.showEnterPasswordFlow()
        }

        navigationController.pushViewController(vc, animated: true)
    }

    func showEnterPasswordFlow() {
        let vc = PasswordViewController()
        vc.completionHandler = { [weak self] password in
            guard let self = self else { return }
            self.user.password = password

            self.flowCompletionHandler?()
        }

        navigationController.pushViewController(vc, animated: true)
    }
}

