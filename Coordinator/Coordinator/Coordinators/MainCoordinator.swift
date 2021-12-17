//
//  MainCoordinator.swift
//  Coordinator
//
//  Created by Евгений Самарин on 17.12.2021.
//

import UIKit

final class MainCoordinator: Coordinator {

    // MARK: - Instance Properties

    var navigationController: UINavigationController
    var flowCompletionHandler: CoordinatorHandler?

    // MARK: -

    private var childCoordinators: [Coordinator] = []

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Instance Methods

    func start() {
        let vc = MainViewController()
        vc.completionHandler = { [weak self] in
            self?.flowCompletionHandler?()
        }

        navigationController.setViewControllers([vc], animated: true)
    }
}
