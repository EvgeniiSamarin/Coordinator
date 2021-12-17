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
    // TODO: - User Service

    private var user = User(login: "", password: "")

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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

