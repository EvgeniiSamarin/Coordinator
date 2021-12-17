//
//  MessagePresenting.swift
//  Coordinator
//
//  Created by Евгений Самарин on 17.12.2021.
//

import UIKit

protocol MessagePresenting {

    // MARK: - Instance Properties

    var presenterController: UIViewController { get }

    // MARK: - Instance Methods

    func showMessage(withTitle title: String?, message: String?, okHandler: (() -> Void)?)
}

// MARK: -

extension MessagePresenting where Self: UIViewController {

    // MARK: - Instance Properties

    var presenterController: UIViewController {
        return self
    }

    // MARK: - Instance Methods

    func showMessage(withTitle title: String?, message: String?, okHandler: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            okHandler?()
        }))

        self.present(alertController, animated: true)
    }

    func showMessage(withTitle title: String?, message: String?) {
        self.showMessage(withTitle: title, message: message, okHandler: nil)
    }
}

